class Usuario {
   int? id; 
  String email;
  String url;
  String descripcion;
  String acercaDe;
  String imagen;
  String nombre;
  String telefono;
  bool visibilidad;
  String contrasena;
  int? codigoRecuperacion;

  Usuario({
    this.id, 
    required this.email,
    required this.url,
    required this.descripcion,
    required this.acercaDe,
    required this.imagen,
    this.nombre = "Usuario",
    required this.telefono,
    this.visibilidad = true,
    required this.contrasena,
    this.codigoRecuperacion,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'], // Asegúrate de mapear el 'id' desde el JSON
      email: json['Email'] ?? '',
      contrasena: json['Contrasenia'] ?? '',
      nombre: json['Nombre'] ?? 'User',
      telefono: json['Telefono'] ?? 'Desconocido',
      imagen: json['Imagen'] ?? 'assets/images/default_user.png',
      url: json['URL'] ?? '',
      descripcion: json['Descripcion'] ?? 'Sin descripción',
      acercaDe: json['AcercaDe'] ?? '',
      visibilidad: json['Visibilidad'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Incluir el 'id' en la conversión a JSON
      'Email': email,
      'Contrasenia': contrasena,
      'Nombre': nombre,
      'Telefono': telefono,
      'Imagen': imagen,
      'Url': url,
      'Descripcion': descripcion,
      'AcercaDe': acercaDe,
      'Visibilidad': visibilidad,
    };
  }
}
