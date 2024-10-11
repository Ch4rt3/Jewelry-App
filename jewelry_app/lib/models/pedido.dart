import 'pedido_producto.dart';

class Pedido {
  final int id;
  final int usuarioId;
  List<PedidoProducto> productosEnPedido;  // Convertido a variable modificable
  final double montoTotal;
  final DateTime fecha;

  Pedido({
    required this.id,
    required this.usuarioId,
    required this.productosEnPedido,
    required this.montoTotal,
    required this.fecha,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    var productosJson = json['Productos'] as List;
    List<PedidoProducto> listaProductos = productosJson.map((prod) => PedidoProducto.fromJson(prod)).toList();

    return Pedido(
      id: json['ID'],
      usuarioId: json['Usuario_ID'],
      productosEnPedido: listaProductos,
      montoTotal: json['MontoTotal'],
      fecha: DateTime.parse(json['Fecha']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Usuario_ID': usuarioId,
      'Productos': productosEnPedido.map((prod) => prod.toJson()).toList(),
      'MontoTotal': montoTotal,
      'Fecha': fecha.toIso8601String(),
    };
  }
}

