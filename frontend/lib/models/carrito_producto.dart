class CarritoProducto {
  final int id;
  final int carritoId;
  final int productoId;  // El ID del producto
  int cantidad;  // Cantidad del producto en el carrito

  CarritoProducto({
    required this.id,
    required this.carritoId,
    required this.productoId,
    required this.cantidad,
  });

  factory CarritoProducto.fromJson(Map<String, dynamic> json) {
    return CarritoProducto(
      id: json['ID'],
      carritoId: json['Carrito_ID'],
      productoId: json['Producto_ID'],
      cantidad: json['Cantidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Carrito_ID': carritoId,
      'Producto_ID': productoId,
      'Cantidad': cantidad,
    };
  }

  @override
  String toString() {
    return 'CarritoProducto{id: $id, carritoId: $carritoId, productoId: $productoId, cantidad: $cantidad}';
  }
}

