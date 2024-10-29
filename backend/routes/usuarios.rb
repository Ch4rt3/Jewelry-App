require 'sinatra'
require 'json'
require 'jwt' # Asegúrate de agregar la gema jwt en tu Gemfile
require_relative '../configs/database'
require_relative '../configs/models'

# Configuración del secreto para JWT
SECRET_KEY = ENV['JWT_SECRET'] || 'tu_clave_secreta_aqui'

# Obtener todos los usuarios
get '/usuarios' do
  content_type :json
  begin
    usuarios = Usuario.all
    usuarios.to_json
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Obtener un usuario por ID
get '/usuarios/:id' do
  content_type :json
  usuario_id = params[:id].to_i
  begin
    usuario = Usuario[usuario_id]
    if usuario
      usuario.to_json
    else
      status 404
      { error: 'Usuario no encontrado' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Obtener un usuario por correo
get '/usuarios/correo/:correo' do
  content_type :json
  correo = params[:correo]
  begin
    usuario = Usuario.where(email: correo).first
    if usuario
      usuario.to_json
    else
      status 404
      { error: 'Usuario no encontrado' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Crear un nuevo usuario
post '/usuarios' do
  content_type :json
  begin
    datos = JSON.parse(request.body.read)
    nuevo_usuario = Usuario.create(datos)
    status 201
    nuevo_usuario.to_json
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al crear el usuario', message: e.message }.to_json
  rescue JSON::ParserError
    status 400
    { error: 'Formato JSON inválido' }.to_json
  end
end

# Actualizar un usuario por ID
put '/usuarios/:id' do
  content_type :json
  usuario_id = params[:id].to_i
  begin
    usuario = Usuario[usuario_id]
    if usuario
      datos = JSON.parse(request.body.read)
      usuario.update(datos)
      usuario.to_json
    else
      status 404
      { error: 'Usuario no encontrado' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al actualizar el usuario', message: e.message }.to_json
  rescue JSON::ParserError
    status 400
    { error: 'Formato JSON inválido' }.to_json
  end
end

post '/usuarios/login' do
  content_type :json
  begin
    datos = JSON.parse(request.body.read)
    puts "Datos recibidos: #{datos}"  # Datos del cliente

    # Busca el usuario por email
    usuario = Usuario.where(Email: datos['email']).first
    puts "Usuario encontrado: #{usuario.inspect}"  # Información del usuario encontrado

    if usuario && usuario.Contrasenia == datos['contrasenia']
      token = JWT.encode({ usuario_id: usuario.id, exp: Time.now.to_i + 4 * 3600 }, SECRET_KEY, 'HS256')
      { token: token, usuario: { id: usuario.id, email: usuario.email } }.to_json
    else
      status 401
      { error: 'Credenciales inválidas' }.to_json
    end
  rescue JSON::ParserError
    status 400
    { error: 'Formato JSON inválido' }.to_json
  end
end
