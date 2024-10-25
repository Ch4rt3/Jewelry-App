import 'carrito_producto.dart';

class Carrito {
  final int id;
  final int usuarioId;
  List<CarritoProducto> productosEnCarrito;  // Convertido a variable modificable
  final double subTotal;

  Carrito({
    required this.id,
    required this.usuarioId,
    required this.productosEnCarrito,
    required this.subTotal,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) {
    var productosJson = json['Productos'] as List;
    List<CarritoProducto> listaProductos = productosJson.map((prod) => CarritoProducto.fromJson(prod)).toList();

    return Carrito(
      id: json['ID'],
      usuarioId: json['Usuario_ID'],
      productosEnCarrito: listaProductos,
      subTotal: json['SubTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Usuario_ID': usuarioId,
      'Productos': productosEnCarrito.map((prod) => prod.toJson()).toList(),
      'SubTotal': subTotal,
    };
  }

  // Método para vaciar el carrito
  void vaciarCarrito() {
    productosEnCarrito.clear();
  }
}

