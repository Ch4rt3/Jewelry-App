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
      id: json['ID'], // Asegúrate de que coincida con la capitalización de tu JSON
      email: json['Email'] ?? '',
      url: json['URL'] ?? '',
      descripcion: json['Descripcion'] ?? 'Sin descripción',
      acercaDe: json['AcercaDe'] ?? '',
      imagen: json['Imagen'] ?? 'assets/images/default_user.png',
      nombre: json['Nombre'] ?? 'User',
      telefono: json['Telefono'] ?? 'Desconocido',
      visibilidad: json['Visibilidad'] ?? true,
      contrasena: json['Contrasenia'] ?? '',
      codigoRecuperacion: json['CodigoRecuperacion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id, // Coincide con la capitalización de tu API si es necesario
      'Email': email,
      'URL': url,
      'Descripcion': descripcion,
      'AcercaDe': acercaDe,
      'Imagen': imagen,
      'Nombre': nombre,
      'Telefono': telefono,
      'Visibilidad': visibilidad,
      'Contrasenia': contrasena,
      'CodigoRecuperacion': codigoRecuperacion,
    };
  }
}
