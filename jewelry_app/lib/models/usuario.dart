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
  String? codigoRecuperacion;

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
      id: json['ID'] is String ? int.tryParse(json['ID']) : json['ID'], // Convierte a int si es String
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
      'ID': id,
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
