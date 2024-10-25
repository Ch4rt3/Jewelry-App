require 'sinatra'
require 'sequel'

# Configuración
set :bind, 'localhost'
set :port, 4568

# Cargar la base de datos y modelos
require_relative 'configs/database'
require_relative 'configs/models'

# Cargar rutas
Dir[File.join(__dir__, 'routes', '*.rb')].each { |file| require_relative file }

# Mensaje indicando que el servidor está corriendo
puts "Servidor corriendo en puerto #{settings.port}."

# CORS
before do
  headers 'Access-Control-Allow-Origin' => '*', # Permitir acceso desde cualquier origen
          'Access-Control-Allow-Methods' => ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'], # Métodos permitidos
          'Access-Control-Allow-Headers' => 'Content-Type' # Encabezados permitidos
end

# Ruta para opciones CORS
options '*' do
  response.headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
  200
end
