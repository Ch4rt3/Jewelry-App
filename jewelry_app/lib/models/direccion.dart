class Direccion {
  int? id;
  int usuarioId;
  int? ciudadId; // Asegúrate de que este campo está definido
  String direccion;
  String codigoPostal;

  Direccion({
    this.id,
    required this.usuarioId,
    this.ciudadId, // Añadido ciudadId aquí
    required this.direccion,
    required this.codigoPostal,
  });

  factory Direccion.fromJson(Map<String, dynamic> json) {
    return Direccion(
      id: json['ID'],
      usuarioId: json['UsuarioId'],
      ciudadId: json['CiudadId'], // Asegúrate de que esto esté presente
      direccion: json['Direccion'],
      codigoPostal: json['codigoPostal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'UsuarioId': usuarioId,
      'CiudadId': ciudadId, // Incluido en el método toJson
      'Direccion': direccion,
      'codigoPostal': codigoPostal,
    };
  }
}
