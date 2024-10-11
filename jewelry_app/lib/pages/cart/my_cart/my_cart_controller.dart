import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MyCartController {
  // Carga el carrito en el provider
  Future<void> cargarCarrito(BuildContext context, Usuario user) async {
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context, listen: false);
    
    // Asegúrate de que el carritoId no sea nulo
    final carritoId = user.carritoId;
    if (carritoId != null) {
      await shoppingCartProvider.loadCart(carritoId); // Asegúrate de esperar la carga
      print("Productos en el carrito después de cargar: ${shoppingCartProvider.productosEnCarrito}");
    } else {
      print("Carrito ID no disponible");
    }
  }
}
