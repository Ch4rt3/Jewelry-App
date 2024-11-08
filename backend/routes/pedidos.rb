require 'sinatra'
require 'json'
require 'sendgrid-ruby'
include SendGrid
require 'dotenv/load'
require_relative '../configs/database'
require_relative '../configs/models'

# Confirmar un carrito y crear un pedido oficial
post '/carrito/:carrito_id/confirmar' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
  
    begin
      # Verificar si el carrito existe
      carrito = Carrito[carrito_id]
      unless carrito
        status 404
        return { error: 'Carrito no encontrado' }.to_json
      end
  
      # Obtener el usuario_id del carrito
      usuario_id = carrito[:Usuario_ID]
  
      # Crear un nuevo pedido
      query_pedido = <<-SQL
        INSERT INTO pedido (Usuario_ID, Fecha, Total)
        VALUES (?, NOW(), ?)
        RETURNING *;
      SQL
      nuevo_pedido = DB[query_pedido, usuario_id, carrito[:SubTotal]].first
  
      # Obtener los productos del carrito
      productos_carrito = CarritoProducto.where(Carrito_ID: carrito_id).all
  
      # Insertar los productos del carrito en la tabla pedido_producto
      productos_carrito.each do |producto|
        query_pedido_producto = <<-SQL
          INSERT INTO pedido_producto (Pedido_ID, Producto_ID, Cantidad, Precio)
          VALUES (?, ?, ?, ?);
        SQL
        DB[query_pedido_producto, nuevo_pedido[:ID], producto[:Producto_ID], producto[:Cantidad], producto[:Precio]].insert
      end
  
      # Vaciamos el carrito
      CarritoProducto.where(Carrito_ID: carrito_id).delete
  
      # Devolver el pedido creado en la respuesta
      status 201
      nuevo_pedido.to_json
  
    rescue Sequel::DatabaseError => e
      status 500
      { error: 'Error al confirmar el pedido', message: e.message }.to_json
    end
end