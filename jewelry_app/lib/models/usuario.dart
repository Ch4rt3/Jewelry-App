
class Usuario {
  final int id;
  String email;
  String url;
  String descripcion;
  String acercaDe;
  String imagen;
  String nombre;
  String telefono;
  bool visibilidad;
  String contrasena;
  final int? carritoId; // Permitir que carritoId sea nulo
  final List<int> pedidos; // Reemplazar `List<dynamic>` con `List<int>`

  Usuario({
    required this.id,
    required this.email,
    required this.url,
    required this.descripcion,
    required this.acercaDe,
    required this.imagen,
    this.nombre = "Usuario",
    required this.telefono,
    this.visibilidad = true,
    required this.contrasena,
    this.carritoId, // Campo opcional para permitir nulo
    this.pedidos = const [],  // Inicializado como lista vacía
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] ?? 0, // Valor predeterminado si es null
      email: json['email'] ?? '',
      contrasena: json['contrasena'] ?? '',
      nombre: json['nombre'] ?? 'Usuario desconocido',
      telefono: json['telefono'] ?? 'Desconocido', // Asegurar que no sea nulo
      imagen: json['imagen'] ?? 'assets/images/default_user.png',
      url: json['url'] ?? '',
      descripcion: json['descripcion'] ?? 'Sin descripción',
      acercaDe: json['acercaDe'] ?? '',
      visibilidad: json['visibilidad'] ?? true,
      carritoId: json['carritoId'] ?? null, // Permitir null aquí
      pedidos: (json['pedidos'] as List<dynamic>?)
              ?.map((item) => item ?? 0) // Reemplazar posibles null en la lista
              .cast<int>()
              .toList() ??
          [], // Lista vacía si es nula
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'contrasena': contrasena,
      'nombre': nombre,
      'telefono': telefono,
      'imagen': imagen,
      'url': url,
      'descripcion': descripcion,
      'acercaDe': acercaDe,
      'visibilidad': visibilidad,
      'carritoId': carritoId,
      'pedidos': pedidos,
    };
  }
}


