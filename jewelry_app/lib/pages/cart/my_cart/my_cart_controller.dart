import 'package:flutter/material.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/services/shoppingcart_service.dart';
import 'package:provider/provider.dart';

class MyCartController {
  // Carga el carrito en el provider
  Future<void> cargarCarrito(BuildContext context, Usuario user) async {
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Usuario? usuario = userProvider.usuario;
    
    // Asegúrate de que el carritoId no sea nulo
    // final carritoId = usuario?.carritoId;
    // if (carritoId != null) {
    //   await shoppingCartProvider.loadCart(carritoId); 
    //   print("Productos en el carrito después de cargar: ${shoppingCartProvider.productosEnCarrito}");
    // } else {
    //   print("Carrito ID no disponible");
    // }
  }

  Future<List<Producto>> cargarCarritoProductos(BuildContext context) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  Usuario? usuario = userProvider.usuario;
  final carritoService = CarritoService();

  // if (usuario?.carritoId != null) {
  //   final carrito = await carritoService.loadCarrito(usuario!.carritoId!);

  //   final productos = await carritoService.loadCarritoProductos(carrito);

  //   return productos;
  // } else {
  //   return [];
  // }
  return [];
}

}
