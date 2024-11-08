import 'package:flutter/material.dart';
import 'package:jewelry_app/providers/product_provider.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePageController {
  final BuildContext context;
  

  HomePageController(this.context);

  // Método para cargar productos
  Future<void> loadProducts() async {
    await Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
  }

  String cargarNombre() {
    final UserProvider usuario = Provider.of<UserProvider>(context, listen: false);
    String nombreCompleto = usuario.usuario!.nombre; // Asumiendo que `nombre` es la propiedad con el nombre completo
    String primerNombre = nombreCompleto.split(' ').first;
    return primerNombre;
  }
  // Puedes agregar más métodos relacionados con la lógica de la página de inicio aquí
}
