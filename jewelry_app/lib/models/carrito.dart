import 'producto.dart';
import 'pedido.dart';

class Carrito {
  final int id;
  final int usuarioId;  // Clave foránea a Usuario
  final List<Producto> productos;  // Relación con productos
  final double subTotal;  // Total del carrito en el momento

  // Relación con Pedido (opcional)
  Pedido? pedido;

  Carrito({
    required this.id,
    required this.usuarioId,
    required this.productos,
    required this.subTotal,
    this.pedido,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) {
    var productosJson = json['Productos'] as List;
    List<Producto> listaProductos = productosJson.map((prod) => Producto.fromJson(prod)).toList();

    return Carrito(
      id: json['ID'],
      usuarioId: json['Usuario_ID'],
      productos: listaProductos,
      subTotal: json['SubTotal'],
      pedido: json['Pedido'] != null ? Pedido.fromJson(json['Pedido']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Usuario_ID': usuarioId,
      'Productos': productos.map((prod) => prod.toJson()).toList(),
      'SubTotal': subTotal,
      'Pedido': pedido?.toJson(),
    };
  }
}


