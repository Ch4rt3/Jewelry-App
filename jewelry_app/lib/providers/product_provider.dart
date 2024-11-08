import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jewelry_app/models/producto.dart';

class ProductProvider with ChangeNotifier {
  List<Producto> _productos = [];
  bool _isLoading = false;

  List<Producto> get productos => _productos;
  bool get isLoading => _isLoading;

  final String baseUrl = 'http://localhost:4568'; // Cambia esta URL por la de tu backend

  // Método para cargar todos los productos desde el backend
  Future<void> fetchAllProducts() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/productos');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _productos = data.map((json) => Producto.fromJson(json)).toList();
      } else {
        print('Error al cargar productos');
      }
    } catch (error) {
      print("Error en la solicitud: $error");
    }

    _isLoading = false;
    notifyListeners();
  }

  // Método para obtener productos por categoría desde el backend
  Future<void> fetchProductsByCategory(String categoria) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/productos/categoria/$categoria');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _productos = data.map((json) => Producto.fromJson(json)).toList();
      } else {
        print('Error al cargar productos por categoría');
      }
    } catch (error) {
      print("Error en la solicitud: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}

