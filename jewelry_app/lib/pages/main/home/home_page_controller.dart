import 'package:flutter/material.dart';
import 'package:jewelry_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomePageController {
  final BuildContext context;

  HomePageController(this.context);

  // Método para cargar productos
  Future<void> loadProducts() async {
    await Provider.of<ProductProvider>(context, listen: false).loadProducts();
  }

  // Puedes agregar más métodos relacionados con la lógica de la página de inicio aquí
}