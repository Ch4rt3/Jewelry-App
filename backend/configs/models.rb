require_relative 'database'

class Usuario < Sequel::Model(DB[:usuarios])

end

class Pago < Sequel::Model(DB[:pagos])

end

class Pais < Sequel::Model(DB[:paises])

end

class Ciudad < Sequel::Model(DB[:ciudades])

end

class Direccion < Sequel::Model(DB[:direcciones])

end

class Pedido < Sequel::Model(DB[:pedidos])

end

class Producto < Sequel::Model(DB[:productos])

end

class PedidoProducto < Sequel::Model(DB[:pedido_productos])

end

class Carrito < Sequel::Model(DB[:carritos])

end

class CarritoProducto < Sequel::Model(DB[:carrito_productos])

end
