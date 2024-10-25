class Producto {
  final int id;
  final String nombre;
  final int precio;
  final int stock;
  final String categoria;
  final String imagenUrl;
  final String descripcion;
  final String descripcionLarga; // Nuevo atributo

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.categoria,
    required this.imagenUrl,
    required this.descripcion,
    required this.descripcionLarga, // Incluye en el constructor
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['ID'],
      nombre: json['Nombre'],
      precio: json['Precio'],
      stock: json['Stock'],
      categoria: json['Categoria'],
      imagenUrl: json['ImagenUrl'],
      descripcion: json['Descripcion'],
      descripcionLarga: json['DescripcionLarga'], // Asigna el nuevo atributo
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Nombre': nombre,
      'Precio': precio,
      'Stock': stock,
      'Categoria': categoria,
      'ImagenUrl': imagenUrl,
      'Descripcion': descripcion,
      'DescripcionLarga': descripcionLarga, // Incluye en el método toJson
    };
  }

  @override
  String toString() {
    return 'Producto{id: $id, nombre: $nombre, precio: $precio, stock: $stock, categoria: $categoria}';
  }
}
