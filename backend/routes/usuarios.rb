require 'sinatra'
require 'json'
require_relative '../configs/database'
require_relative '../configs/models'

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
