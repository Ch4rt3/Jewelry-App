class Producto {
  final int id;
  final String nombre;
  final int precio;
  final int stock;
  final String categoria;
  final String imagenUrl;
  final String descripcion;  

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.categoria,
    required this.imagenUrl,
    required this.descripcion,
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
    };
  }

  @override
  String toString() {
    return 'Producto{id: $id, nombre: $nombre, precio: $precio, stock: $stock, categoria: $categoria}';
  }
}


