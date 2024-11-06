class Tarjeta {
  int? id;
  String usuarioId;
  String numeroTarjeta;
  String nombreTitular;
  String expFecha;
  String cvv;

  Tarjeta({
    this.id,
    required this.usuarioId,
    required this.numeroTarjeta,
    required this.nombreTitular,
    required this.expFecha,
    required this.cvv,
  });

  factory Tarjeta.fromJson(Map<String, dynamic> json) {
    return Tarjeta(
      id: json['ID'],
      usuarioId: json['UsuarioId'].toString(), // Asegura que usuarioId esté en String
      numeroTarjeta: json['numeroTarjeta'].toString(), // Convierte numeroTarjeta a String
      nombreTitular: json['nombreTitular'] ?? 'N/A', // Valor por defecto si es nulo
      expFecha: json['expFecha'] ?? 'N/A',
      cvv: json['CCV'].toString(), // Convierte CVV a String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'UsuarioId': usuarioId,
      'numeroTarjeta': numeroTarjeta,
      'nombreTitular': nombreTitular,
      'expFecha': expFecha,
      'CCV': cvv,
    };
  }
}
