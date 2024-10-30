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
  status = 500
  resp = ''

  begin
    datos = JSON.parse(request.body.read)
    correo = datos['email']
    contrasenia = datos['contrasenia']
    puts "Datos recibidos: #{datos}"  # Log para debug

    # Query directa para encontrar al usuario
    query = <<-SQL
      SELECT * FROM usuarios WHERE email = '#{correo}' AND contrasenia = '#{contrasenia}';
    SQL
    usuario = DB[query].first  # Ejecutar la consulta y obtener el primer resultado

    puts "Usuario encontrado: #{usuario.inspect}"  # Log de usuario encontrado

    if usuario
      # Acceder a las claves correctamente
      token = JWT.encode({ usuario_id: usuario[:ID], exp: Time.now.to_i + 4 * 3600 }, SECRET_KEY, 'HS256')
      status = 200
      resp = {
        token: token,
        usuario: { 
          id: usuario[:ID],  # Acceso a ID
          email: usuario[:Email]  # Acceso a Email
        }
      }.to_json
    else
      status = 401
      resp = { error: 'Credenciales inválidas' }.to_json
    end
  rescue JSON::ParserError
    status = 400
    resp = { error: 'Formato JSON inválido' }.to_json
  rescue Sequel::DatabaseError => e
    resp = { error: e.message }.to_json
  rescue StandardError => e
    resp = { error: e.message }.to_json
  end

  status status
  resp
end



