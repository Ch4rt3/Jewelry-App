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
  final String contrasena;  // Nuevo atributo

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
    required this.contrasena,  // Asignación de contraseña
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
      'Contrasena': contrasena,  // Incluye la contraseña
    };
  }

  @override
  String toString() {
    return 'Usuario{id: $id, nombre: $nombre, email: $email}';
  }
}
