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
  // Método para obtener productos por categoría
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
}
