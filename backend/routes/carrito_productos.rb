require 'sinatra'
require 'json'
require 'sendgrid-ruby'
include SendGrid
require 'dotenv/load'
require_relative '../configs/database'
require_relative '../configs/models'

# Agregar un producto al carrito
post '/carrito/:carrito_id/producto/:producto_id' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
    producto_id = params[:producto_id].to_i
    begin
        datos = JSON.parse(request.body.read)
        cantidad = datos['cantidad'].to_i
# Verificar si el producto ya está en el carrito
        carrito_producto = CarritoProducto.where(Carrito_ID: carrito_id, Producto_ID: producto_id).first 
        if carrito_producto
# Si el producto ya está en el carrito, aumentar la cantidad
            nueva_cantidad = carrito_producto[:Cantidad] + cantidad
            carrito_producto.update(Cantidad: nueva_cantidad)
            status 200
            carrito_producto.to_json
        else
# Si el producto no está en el carrito, agregar la relación
            nuevo_carrito_producto = CarritoProducto.create(Carrito_ID: carrito_id, Producto_ID: producto_id, Cantidad: cantidad)
            status 201
            nuevo_carrito_producto.to_json
        end
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al agregar el producto al carrito', message: e.message }.to_json
    rescue JSON::ParserError
        status 400
        {error: 'Formato JSON inválido' }.to_json
    end
end

# Aumentar la cantidad de un producto en el carrito
put '/carrito/:carrito_id/producto/:producto_id' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
    producto_id = params[:producto_id].to_i
    begin
        datos = JSON.parse(request.body.read)
        cantidad_aumentar = datos['cantidad'].to_i
# Verificar si el producto ya está en el carrito
        carrito_producto = CarritoProducto.where(Carrito_ID: carrito_id, Producto_ID: producto_id).first
        if carrito_producto
# Aumentar la cantidad del producto en el carrito
            nueva_cantidad = carrito_producto[:Cantidad] + cantidad_aumentar
            carrito_producto.update(Cantidad: nueva_cantidad)
            status 200
            carrito_producto.to_json
        else
            status 404
            { error: 'Producto no encontrado en el carrito' }.to_json
        end
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al actualizar la cantidad del producto', message: e.message }.to_json
    rescue JSON::ParserError
        status 400
        { error: 'Formato JSON inválido' }.to_json
    end
end

# Obtener los productos de un carrito específico
get '/carrito/:carrito_id/productos' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
    begin
# Obtener los productos del carrito
        carrito_productos = CarritoProducto.where(Carrito_ID: carrito_id).all
        if carrito_productos.any?
            productos = carrito_productos.map do |cp|
            producto = Producto[cp[:Producto_ID]]
            {
                producto: producto,
                cantidad: cp[:Cantidad]
            }
            end
            status 200
            productos.to_json
        else
            status 404
            { error: 'No se encontraron productos en el carrito' }.to_json
        end
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al acceder a la base de datos', message: e.message }.to_json
    end
end
