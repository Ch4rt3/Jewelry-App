import 'package:flutter/material.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductoService _productoService = ProductoService(); // Instancia del servicio
  List<Producto> _productos = [];
  bool _isLoading = false;

  List<Producto> get productos => _productos;
  bool get isLoading => _isLoading;

  // Método para cargar productos
  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _productos = await _productoService.fetchAll(); // Usa el servicio para cargar productos

    _isLoading = false;
    notifyListeners();
  }
}