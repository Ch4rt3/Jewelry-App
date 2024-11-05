require 'sinatra'
require 'json'
require 'sendgrid-ruby'
include SendGrid
require 'dotenv/load'
require_relative '../configs/database'
require_relative '../configs/models'

#obtener todos los productos
get '/productos' do 
    content_type :json
    begin 
        productos = Producto.all
        productos.to_json
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al acceder a la base de datos', message: e.message }.to_json
    end
end
# Obtener productos por categoría
get '/productos/categoria/:categoria' do
    content_type :json
    categoria = params[:categoria]
    begin
# Obtener los productos que coincidan con la categoría
    productos = Producto.where(Categoria: categoria).all
    if productos.any?
        status 200
        productos.to_json
    else
        status 404
        { error: 'No se encontraron productos en la categoría especificada' }.to_json
    end
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al acceder a la base de datos', message: e.message }.to_json
    end
end
# Agregar un nuevo producto
post '/productos' do
    content_type :json
    begin
# Parsear los datos JSON del request
    datos = JSON.parse(request.body.read)
    puts "-----------------------------"
    puts datos
# Extraer los valores del JSON
    nombre = datos['Nombre']
    precio = datos['Precio']
    stock = datos['Stock']
    categoria = datos['Categoria']
    imagen_url = datos['ImagenUrl']
    descripcion = datos['Descripcion']
    descripcion_larga = datos['DescripcionLarga']
# Insertar el producto en la base de datos usando parámetros
    query = <<-SQL
        INSERT INTO productos (Nombre, Precio, Stock, Categoria, ImagenUrl, Descripcion, DescripcionLarga)
        VALUES (?, ?, ?, ?, ?, ?, ?)
        RETURNING *;
    SQL
# Ejecutar la consulta y obtener el producto recién creado
    nuevo_producto = DB[query, nombre, precio, stock, categoria, imagen_url, descripcion, descripcion_larga].first
# Devolver el producto creado en la respuesta
    status 201
    nuevo_producto.to_json
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al crear el producto', message: e.message }.to_json
    rescue JSON::ParserError
        status 400
        { error: 'Formato JSON inválido' }.to_json
    end
end