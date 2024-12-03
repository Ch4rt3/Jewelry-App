import 'package:flutter/material.dart';
import 'package:jewelry_app/services/product_service.dart';
import 'package:jewelry_app/models/producto.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  // Lista de productos
  List<Producto> _productos = [];
  List<Producto> get productos => _productos;

  // Subtotal
  double _subtotal = 0.0;
  double get subtotal => _subtotal; // Getter para el subtotal

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

  // Cargar productos de un carrito específico
  Future<void> fetchProductsByCartId(int carritoId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Llamar al servicio para obtener productos y el subtotal
      _productos = await _productService.fetchProductsByCartId(carritoId);
    } catch (error) {
      print('Error al cargar productos del carrito: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


