require 'sinatra'
require 'json'
require_relative '../configs/database'
require_relative '../configs/models'

# Obtener todas las direcciones
get '/direcciones' do
  content_type :json
  begin
    direcciones = Direccion.all
    direcciones.to_json
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Obtener direcciones de un usuario específico por usuarioId
get '/direcciones/usuario/:usuarioId' do
  content_type :json
  usuario_id = params[:usuarioId].to_i
  begin
    direcciones = Direccion.where(UsuarioId: usuario_id).all
    if direcciones.any?
      direcciones.to_json
    else
      status 404
      { error: 'No se encontraron direcciones para este usuario' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Crear una nueva dirección
post '/direcciones' do
  content_type :json
  begin
    datos = JSON.parse(request.body.read)
    nueva_direccion = Direccion.create(
      UsuarioId: datos['UsuarioId'],
      CiudadId: datos['CiudadId'],
      Direccion: datos['Direccion'],
      codigoPostal: datos['codigoPostal']
    )
    status 201
    nueva_direccion.to_json
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al crear la dirección', message: e.message }.to_json
  rescue JSON::ParserError
    status 400
    { error: 'Formato JSON inválido' }.to_json
  end
end

# Eliminar una dirección por ID
delete '/direcciones/:id' do
  content_type :json
  direccion_id = params[:id].to_i
  begin
    direccion = Direccion[direccion_id]
    if direccion
      direccion.delete
      { message: 'Dirección eliminada exitosamente' }.to_json
    else
      status 404
      { error: 'Dirección no encontrada' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al eliminar la dirección', message: e.message }.to_json
  end
end
