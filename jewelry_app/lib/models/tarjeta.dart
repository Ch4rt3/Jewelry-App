class Tarjeta {
  int? id;
  String usuarioId; // usuarioId como String
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
      usuarioId: json['UsuarioId'].toString(),
      numeroTarjeta: json['numeroTarjeta'],
      nombreTitular: json['nombreTitular'],
      expFecha: json['expFecha'],
      cvv: json['CCV'],
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
