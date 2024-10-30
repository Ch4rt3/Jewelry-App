require 'sinatra'
require 'json'
require 'jwt' # Asegúrate de agregar la gema jwt en tu Gemfile
require 'sendgrid-ruby'
include SendGrid
require 'dotenv/load'
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

post '/usuarios/restablecer-contrasenia' do
  content_type :json
  status = 500
  resp = ''

  begin
    datos = JSON.parse(request.body.read)
    correo = datos['email']
    puts "Email recibido: #{correo}"  # Log para debug

    # Generar un código de recuperación aleatorio
    codigo_recuperacion = rand(100000..999999).to_s
    puts "Código de recuperación generado: #{codigo_recuperacion}"  # Log del código

    # Buscar al usuario por email
    usuario = Usuario.where(email: correo).first

    if usuario
      # Actualizar el usuario con el código de recuperación
      usuario.update(CodigoRecuperacion: codigo_recuperacion)

      # Enviar el correo electrónico
      from = Email.new(email: 'noreply.greenfieldjewelry@gmail.com')
      to = Email.new(email: correo)
      subject = 'Recuperación de Contraseña'
      content = Content.new(type: 'text/plain', value: "Aquí tienes tu código de recuperación: #{codigo_recuperacion}")

      mail = Mail.new(from, subject, to, content)

      # Crear la instancia del API con tu clave de SendGrid
      sg = SendGrid::API.new(api_key: ENV['API_KEY'])

      # Realizar la solicitud de envío
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      
      puts response.status_code
      puts response.body
      puts response.headers

      if response.status_code.to_i == 202
        status = 200
        resp = { message: 'Código de recuperación enviado a tu correo' }.to_json
      else
        status = 500
        resp = { error: 'Error al enviar el correo' }.to_json
      end
    else
      status = 404
      resp = { error: 'Usuario no encontrado' }.to_json
    end
  rescue JSON::ParserError
    status = 400
    resp = { error: 'Formato JSON inválido' }.to_json
  rescue StandardError => e
    resp = { error: e.message }.to_json
  end

  status status
  resp
end


post '/usuarios/actualizar-contrasenia' do
  content_type :json
  status = 500
  resp = ''

  begin
    datos = JSON.parse(request.body.read)
    correo = datos['email']
    nueva_contrasenia = datos['nueva_contrasenia']
    codigo_recuperacion = datos['codigo_recuperacion']
    
    puts "Email recibido: #{correo}"  # Log para debug
    puts "Código de recuperación recibido: #{codigo_recuperacion}"  # Log del código

    # Aquí deberías verificar si el código de recuperación es válido. Este paso puede involucrar
    # almacenarlo en la base de datos o en una estructura temporal.

    # Si el código es válido, actualizar la contraseña
    query = <<-SQL
      UPDATE usuarios SET contrasenia = '#{nueva_contrasenia}' WHERE email = '#{correo}' AND CodigoRecuperacion = '#{codigo_recuperacion}';
    SQL

    records = DB[query].update  # Ejecutar la consulta

    if records > 0
      status = 200
      resp = { message: 'Contraseña actualizada correctamente' }.to_json
    else
      status = 400
      resp = { error: 'Código de recuperación inválido o no se encontró el usuario' }.to_json
    end
  rescue JSON::ParserError
    status = 400
    resp = { error: 'Formato JSON inválido' }.to_json
  rescue StandardError => e
    resp = { error: e.message }.to_json
  end

  status status
  resp
end

