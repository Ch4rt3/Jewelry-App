require 'sinatra'
require 'json'
require 'sendgrid-ruby'
include SendGrid
require 'dotenv/load'
require_relative '../configs/database'
require_relative '../configs/models'

# Obtener el carrito y todos sus productos
get '/carrito/:usuario_id' do
    content_type :json
    usuario_id = params[:usuario_id].to_i
    begin
        carrito = Carrito.where(Usuario_ID: usuario_id).first
    if carrito
        carrito_productos = DB[:CarritoProducto].join(:Producto, ID: :Producto_ID).where(Carrito_ID: carrito[:ID]).all
        carrito.merge(productos: carrito_productos).to_json
    else
        status 404
        { error: 'Carrito no encontrado para el usuario especificado' }.to_json
    end
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al acceder a la base de datos', message: e.message }.to_json
    end
end
# Agregar un nuevo carrito vacío para un usuario
    post '/carrito' do
    content_type :json
    begin
# Parsear los datos JSON del request
    datos = JSON.parse(request.body.read)
    usuario_id = datos['Usuario_ID']
# Insertar el carrito vacío en la base de datos
    query = <<-SQL
        INSERT INTO carrito (Usuario_ID, SubTotal)
        VALUES (?, ?)
        RETURNING *;
    SQL
# Ejecutar la consulta y obtener el carrito recién creado
    nuevo_carrito = DB[query, usuario_id, 0].first
# Devolver el carrito creado en la respuesta
    status 201
    nuevo_carrito.to_json
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al crear el carrito', message: e.message }.to_json
    rescue JSON::ParserError
        status 400
        { error: 'Formato JSON inválido' }.to_json
    end
end