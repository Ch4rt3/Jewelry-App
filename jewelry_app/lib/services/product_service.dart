import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jewelry_app/models/producto.dart';

class ProductoService {
  // Método para obtener todos los productos
  Future<List<Producto>> fetchAll() async {
    try {
      final String response = await rootBundle.loadString('assets/json/productos.json');
      final List<dynamic> data = jsonDecode(response);
      return data.map((json) => Producto.fromJson(json)).toList();
    } catch (e) {
      print("Error al cargar productos: $e");
      return [];
    }
  }

  // Método para obtener un producto por ID
  Future<Producto?> getProductoById(int id) async {
  try {
    List<Producto> productos = await fetchAll();
    return productos.firstWhere(
      (producto) => producto.id == id,
      orElse: () => Producto(
        id: 0, // Valor temporal para producto no encontrado
        nombre: "No Encontrado",
        precio: 0,
        stock: 0,
        categoria: "Desconocida",
        imagenUrl: "assets/images/default.png",
        descripcion: "Este producto no está disponible.",
      ),
    );
  } catch (e) {
    print("Error al obtener producto por ID: $e");
    return null;
  }
}

  // Método para obtener productos por categoría
  Future<List<Producto>> getProductosByCategoria(String categoria) async {
    try {
      List<Producto> productos = await fetchAll();
      return productos.where((producto) => producto.categoria.toLowerCase() == categoria.toLowerCase()).toList();
    } catch (e) {
      print("Error al obtener productos por categoría: $e");
      return [];
    }
  }
  Producto obtenerProductoTemporal(int id) {
  return Producto(
    id: id,
    nombre: "Producto No Disponible",
    precio: 0,
    stock: 0,
    categoria: "Desconocida",
    imagenUrl: "assets/images/default.png",
    descripcion: "Este producto no está disponible.",
  );
}

}
