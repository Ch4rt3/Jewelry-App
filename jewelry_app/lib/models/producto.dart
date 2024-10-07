class Producto {
  final int id;
  final String nombre;
  final int precio;
  final int stock;
  final String categoria;  
  final String imagenUrl;  

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.categoria,
    required this.imagenUrl,
  });

  @override
  String toString() {
    return 'Producto{id: $id, nombre: $nombre, precio: $precio, categoria: $categoria}';
  }

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['ID'],
      nombre: json['Nombre'],
      precio: json['Precio'],
      stock: json['Stock'],
      categoria: json['Categoria'],  
      imagenUrl: json['ImagenUrl'],  
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
    };
  }
}

