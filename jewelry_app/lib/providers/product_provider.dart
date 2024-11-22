import 'package:flutter/material.dart';
import 'package:jewelry_app/services/product_service.dart'; // Import del servicio
import 'package:jewelry_app/models/producto.dart'; // Modelo del producto

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();
  // Lista de productos
  List<Producto> _productos = [];
  List<Producto> get productos => _productos;

  // Indicador de carga
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Cargar todos los productos
  Future<void> fetchAllProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _productos = await _productService.fetchAllProducts();
    } catch (error) {
      print('Error al cargar todos los productos: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cargar productos por categoría
  Future<void> fetchProductsByCategory(String categoria) async {
    _isLoading = true;
    notifyListeners();

    try {
      _productos = await _productService.fetchProductsByCategory(categoria);
    } catch (error) {
      print('Error al cargar productos por categoría: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

