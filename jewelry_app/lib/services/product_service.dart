import 'dart:convert';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/services/api_base_service.dart';
import 'package:http/http.dart' as http;

class ProductService extends ApiBaseService {
  // Obtener todos los productos
  Future<List<Producto>> fetchAllProducts() async {
    final String endpoint = '/productos';
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar todos los productos');
    }
  }

  // Obtener productos por categoría
  Future<List<Producto>> fetchProductsByCategory(String categoria) async {
    final String endpoint = '/productos/categoria/$categoria';
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Producto.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos por categoría');
    }
  }

  Future<List<Producto>> fetchProductsByCartId(int carritoId) async {
  final String endpoint = '/carrito/$carritoId/productos';
  final response = await http.get(Uri.parse('$baseUrl$endpoint'));

  if (response.statusCode == 200) {
    // Decodificar la respuesta JSON
    final Map<String, dynamic> data = json.decode(response.body);

    // Acceder a la lista de productos
    final List<dynamic> productos = data['productos'];

    // Mapear cada producto
    return productos.map((productoJson) => Producto.fromJson(productoJson)).toList();
  } else {
    throw Exception('Error al cargar productos del carrito');
  }
}

}
