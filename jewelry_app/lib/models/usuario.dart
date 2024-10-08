import 'pedido.dart';
import 'carrito.dart';

class Usuario {
  final int id;
  final String email;
  final String url;
  final String descripcion;
  final String acercaDe;
  final String imagen;
  final String nombre;
  final String telefono;
  final bool visibilidad;
  final String contrasena; 

  // Carrito del usuario (relación 1 a 1)
  Carrito? carrito;  // Relación con el carrito
  // Lista de pedidos (relación 1 a N)
  List<Pedido>? pedidos;  // Relación con los pedidos

  Usuario({
    required this.id,
    required this.email,
    required this.url,
    required this.descripcion,
    required this.acercaDe,
    required this.imagen,
    required this.nombre,
    required this.telefono,
    required this.visibilidad,
    required this.contrasena,
    this.carrito,
    this.pedidos,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['ID'],
      email: json['Email'],
      url: json['URL'],
      descripcion: json['Descripcion'],
      acercaDe: json['AcercaDe'],
      imagen: json['Imagen'],
      nombre: json['Nombre'],
      telefono: json['Telefono'],
      visibilidad: json['Visibilidad'],
      contrasena: json['Contrasena'],
      carrito: json['Carrito'] != null ? Carrito.fromJson(json['Carrito']) : null,
      pedidos: json['Pedidos'] != null
          ? (json['Pedidos'] as List).map((p) => Pedido.fromJson(p)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Email': email,
      'URL': url,
      'Descripcion': descripcion,
      'AcercaDe': acercaDe,
      'Imagen': imagen,
      'Nombre': nombre,
      'Telefono': telefono,
      'Visibilidad': visibilidad,
      'Contrasena': contrasena,
      'Carrito': carrito?.toJson(),
      'Pedidos': pedidos?.map((p) => p.toJson()).toList(),
    };
  }
}

