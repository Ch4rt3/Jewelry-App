import 'producto.dart';

class Pedido {
  final int id;
  final String codigo;
  final DateTime fecha;  
  final double montoTotal;  
  final int usuarioId;  
  final List<Producto> productos; 

  Pedido({
    required this.id,
    required this.codigo,
    required this.fecha,
    required this.montoTotal,
    required this.usuarioId,
    required this.productos,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    var productosJson = json['Productos'] as List;
    List<Producto> listaProductos = productosJson.map((prod) => Producto.fromJson(prod)).toList();

    return Pedido(
      id: json['ID'],
      codigo: json['Codigo'],
      fecha: DateTime.parse(json['Fecha']),  
      montoTotal: json['MontoTotal'],
      usuarioId: json['Usuario_ID'],
      productos: listaProductos,  
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Codigo': codigo,
      'Fecha': fecha.toIso8601String(), 
      'MontoTotal': montoTotal,
      'Usuario_ID': usuarioId,
      'Productos': productos.map((prod) => prod.toJson()).toList(),  
    };
  }

  @override
  String toString() {
    return 'Pedido{id: $id, codigo: $codigo, montoTotal: $montoTotal}';
  }
}
