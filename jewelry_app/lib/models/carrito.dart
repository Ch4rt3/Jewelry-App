import 'producto.dart';

class Carrito {
  final int id;
  final int usuarioId;  
  final List<Producto> productos;  
  final double subTotal; 

  Carrito({
    required this.id,
    required this.usuarioId,
    required this.productos,
    required this.subTotal,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) {
    var productosJson = json['Productos'] as List;
    List<Producto> listaProductos = productosJson.map((prod) => Producto.fromJson(prod)).toList();

    return Carrito(
      id: json['ID'],
      usuarioId: json['Usuario_ID'],
      productos: listaProductos, 
      subTotal: json['SubTotal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Usuario_ID': usuarioId,
      'Productos': productos.map((prod) => prod.toJson()).toList(), 
      'SubTotal': subTotal,
    };
  }

  @override
  String toString() {
    return 'Carrito{id: $id, usuarioId: $usuarioId, subTotal: $subTotal}';
  }
}
