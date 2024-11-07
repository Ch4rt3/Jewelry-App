require 'sinatra'
require 'json'
require_relative '../configs/database'
require_relative '../configs/models'

# Obtener todas las tarjetas (pagos)
get '/wallets' do
  content_type :json
  begin
    tarjetas = Pago.all
    tarjetas.to_json
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Obtener todas las tarjetas de un usuario específico por usuarioId
get '/wallets/usuario/:usuarioId' do
  content_type :json
  usuario_id = params[:usuarioId].to_i
  begin
    tarjetas = Pago.where(UsuarioId: usuario_id).all
    if tarjetas.any?
      tarjetas.to_json
    else
      status 404
      { error: 'No se encontraron tarjetas para este usuario' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Obtener una tarjeta por ID
get '/wallets/:id' do
  content_type :json
  tarjeta_id = params[:id].to_i
  begin
    tarjeta = Pago[tarjeta_id]
    if tarjeta
      tarjeta.to_json
    else
      status 404
      { error: 'Tarjeta no encontrada' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Crear una nueva tarjeta
post '/wallets' do
  content_type :json
  begin
    datos = JSON.parse(request.body.read)

    numero_tarjeta = datos['numeroTarjeta']
    ccv = datos['CCV']
    exp_fecha = datos['expFecha']
    nombre_titular = datos['nombreTitular']
    usuario_id = datos['UsuarioId']

    query = <<-SQL
      INSERT INTO pagos (numeroTarjeta, CCV, expFecha, nombreTitular, UsuarioId)
      VALUES (?, ?, ?, ?, ?)
      RETURNING *;
    SQL

    nueva_tarjeta = DB[query, numero_tarjeta, ccv, exp_fecha, nombre_titular, usuario_id].first

    status 201
    nueva_tarjeta.to_json
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al crear la tarjeta', message: e.message }.to_json
  rescue JSON::ParserError
    status 400
    { error: 'Formato JSON inválido' }.to_json
  end
end

# Eliminar una tarjeta por ID
delete '/wallets/:id' do
  content_type :json
  tarjeta_id = params[:id].to_i
  begin
    tarjeta = Pago[tarjeta_id]
    if tarjeta
      tarjeta.delete
      { message: 'Tarjeta eliminada exitosamente' }.to_json
    else
      status 404
      { error: 'Tarjeta no encontrada' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al eliminar la tarjeta', message: e.message }.to_json
  end
end
