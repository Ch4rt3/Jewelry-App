class Ciudad {
  final int id;
  final String nombre;
  final int paisId;

  Ciudad({required this.id, required this.nombre, required this.paisId});

  factory Ciudad.fromJson(Map<String, dynamic> json) {
    return Ciudad(
      id: json['ID'],
      nombre: json['nombreCiudad'],
      paisId: json['PaisId'],
    );
  }
}
