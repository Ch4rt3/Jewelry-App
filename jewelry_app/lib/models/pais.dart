class Pais {
  final int id;
  final String nombre;

  Pais({required this.id, required this.nombre});

  factory Pais.fromJson(Map<String, dynamic> json) {
    return Pais(
      id: json['ID'],
      nombre: json['nombrePais'],
    );
  }
}
