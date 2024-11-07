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
# Actualizar el subtotal del carrito
put '/carrito/:carrito_id/actualizar_subtotal' do
    content_type :json
    carrito_id = params[:carrito_id].to_i
    begin
        # Obtener los productos del carrito
        carrito_productos = CarritoProducto.where(Carrito_ID: carrito_id).all
        if carrito_productos.any?
            # Calcular el nuevo subtotal
            nuevo_subtotal = carrito_productos.inject(0) do |subtotal, cp|
            producto = Producto[cp[:Producto_ID]]
            subtotal + (producto[:Precio] * cp[:Cantidad])
            end
            # Actualizar el subtotal en la tabla Carrito
            carrito = Carrito[carrito_id]
            if carrito
                carrito.update(SubTotal: nuevo_subtotal)
                status 200
                { carrito_id: carrito_id, nuevo_subtotal: nuevo_subtotal }.to_json
            else    
                status 404
                { error: 'Carrito no encontrado' }.to_json
            end
        else
            status 404
            { error: 'No se encontraron productos en el carrito' }.to_json
        end
    rescue Sequel::DatabaseError => e
        status 500
        { error: 'Error al acceder a la base de datos', message: e.message }.to_json
    end
end
# Agregar un nuevo carrito vacío para un usuario específico
post '/usuarios/:usuario_id/carrito' do
    content_type :json
    begin
      # Obtener el usuario_id de los parámetros de la URL
      usuario_id = params[:usuario_id].to_i
  
      # Verificar que el usuario_id sea válido
      if usuario_id <= 0
        status 400
        return { error: 'Usuario_ID debe ser un número entero válido' }.to_json
      end
  
      # Insertar el carrito vacío en la base de datos
      query = <<-SQL
        INSERT INTO carrito (Usuario_ID, SubTotal)
        VALUES (?, 0)
        RETURNING *;
      SQL
  
      # Ejecutar la consulta y obtener el carrito recién creado
      nuevo_carrito = DB[query, usuario_id].first
  
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
  