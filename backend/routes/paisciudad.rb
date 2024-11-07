require 'sinatra'
require 'json'
require_relative '../configs/database'
require_relative '../configs/models'

# Obtener todos los países
get '/paises' do
  content_type :json
  begin
    paises = Pais.all
    paises.to_json
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end

# Obtener ciudades de un país específico
get '/ciudades/pais/:paisId' do
  content_type :json
  pais_id = params[:paisId].to_i
  begin
    ciudades = Ciudad.where(PaisId: pais_id).all
    if ciudades.any?
      ciudades.to_json
    else
      status 404
      { error: 'No se encontraron ciudades para este país' }.to_json
    end
  rescue Sequel::DatabaseError => e
    status 500
    { error: 'Error al acceder a la base de datos', message: e.message }.to_json
  end
end
