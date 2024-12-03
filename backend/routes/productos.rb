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

get '/productos/carrito/:carrito_id' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
  
    begin
      # Verificar si el carrito existe
      carrito = DB[:carritos].where(ID: carrito_id).first
  
      if carrito
        # Obtener productos asociados al carrito desde la tabla intermedia
        productos = DB[:productos]
                    .join(:carrito_productos, ProductoId: :ID)
                    .where(CarritoId: carrito_id)
                    .select(
                      Sequel[:productos][:ID].as(:id),
                      Sequel[:productos][:Nombre].as(:nombre),
                      Sequel[:productos][:Precio].as(:precio),
                      Sequel[:productos][:Stock].as(:stock),
                      Sequel[:productos][:Categoria].as(:categoria),
                      Sequel[:productos][:ImagenUrl].as(:imagen_url),
                      Sequel[:productos][:Descripcion].as(:descripcion),
                      Sequel[:productos][:DescripcionLarga].as(:descripcion_larga),
                      Sequel[:carrito_productos][:Cantidad].as(:cantidad) # Cantidad desde la tabla intermedia
                    )
                    .all
  
        # Responder con los datos
        productos.to_json
      else
        status 404
        { error: 'Carrito no encontrado' }.to_json
      end
    rescue Sequel::DatabaseError => e
      status 500
      { error: 'Error al acceder a la base de datos', message: e.message }.to_json
    end
  end
  

