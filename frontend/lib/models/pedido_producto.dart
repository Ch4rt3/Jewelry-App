class PedidoProducto {
  final int id;
  final int pedidoId;  // ID del Pedido
  final int productoId;  // ID del Producto
  final int cantidad;  // Cantidad de producto en el pedido

  PedidoProducto({
    required this.id,
    required this.pedidoId,
    required this.productoId,
    required this.cantidad,
  });

  factory PedidoProducto.fromJson(Map<String, dynamic> json) {
    return PedidoProducto(
      id: json['ID'],
      pedidoId: json['Pedido_ID'],
      productoId: json['Producto_ID'],
      cantidad: json['Cantidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Pedido_ID': pedidoId,
      'Producto_ID': productoId,
      'Cantidad': cantidad,
    };
  }
}
