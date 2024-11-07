require 'sinatra'
require 'json'
require 'sendgrid-ruby'
include SendGrid
require 'dotenv/load'
require_relative '../configs/database'
require_relative '../configs/models'

# Modificar la cantidad de un producto en el carrito
put '/carrito/:carrito_id/producto/:producto_id' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
    producto_id = params[:producto_id].to_i
    begin
      datos = JSON.parse(request.body.read)
      nueva_cantidad = datos['cantidad'].to_i
      # Verificar si el producto ya está en el carrito
      carrito_producto = CarritoProducto.where(Carrito_ID: carrito_id, Producto_ID: producto_id).first
      if carrito_producto
        if nueva_cantidad > 0
          # Modificar la cantidad del producto en el carrito
          carrito_producto.update(Cantidad: nueva_cantidad)
          status 200
          carrito_producto.to_json
        else
          # Eliminar la relación si la cantidad es cero o menor
          carrito_producto.delete
          status 200
          { message: 'Producto eliminado del carrito' }.to_json
        end
      else
        if nueva_cantidad > 0
          # Si el producto no está en el carrito y la cantidad es mayor que 0, agregar la relación
          nuevo_carrito_producto = CarritoProducto.create(Carrito_ID: carrito_id, Producto_ID: producto_id, Cantidad: nueva_cantidad)
          status 201
          nuevo_carrito_producto.to_json
        else
          status 400
          { error: 'La cantidad debe ser mayor que 0 para agregar un nuevo producto al carrito' }.to_json
        end
      end
    rescue Sequel::DatabaseError => e
      status 500
      { error: 'Error al modificar la cantidad del producto en el carrito', message: e.message }.to_json
    rescue JSON::ParserError
      status 400
      { error: 'Formato JSON inválido' }.to_json
    end
end

# Eliminar un producto específico del carrito
delete '/carrito/:carrito_id/producto/:producto_id' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
    producto_id = params[:producto_id].to_i
  
    begin
      # Verificar si el producto está en el carrito
      carrito_producto = CarritoProducto.where(Carrito_ID: carrito_id, Producto_ID: producto_id).first
  
      if carrito_producto
        # Eliminar el producto del carrito
        carrito_producto.delete
        status 200
        { message: 'Producto eliminado del carrito' }.to_json
      else
        status 404
        { error: 'Producto no encontrado en el carrito' }.to_json
      end
    rescue Sequel::DatabaseError => e
      status 500
      { error: 'Error al eliminar el producto del carrito', message: e.message }.to_json
    end
end
  
