import 'package:flutter/material.dart';
import 'package:jewelry_app/models/carrito.dart';
import '../models/producto.dart';
import '../models/carrito_producto.dart';
import '../services/shoppingcart_service.dart';
import 'package:provider/provider.dart';
import 'order_provider.dart';

class ShoppingCartProvider extends ChangeNotifier {
  final CarritoService _carritoService = CarritoService();

  // Variables internas para manejar el estado del carrito
  List<Producto> _productosEnCarrito = [];
  List<CarritoProducto> _carritoProductos = [];
  bool _isLoading = false;

  // Getters
  List<Producto> get productosEnCarrito => _productosEnCarrito;
  bool get isLoading => _isLoading;
  double get subTotal {
  double total = 0.0;
  for (var producto in _carritoProductos) {
    total += producto.cantidad * _productosEnCarrito.firstWhere((p) => p.id == producto.productoId).precio;
  }
    return total;
  }
  int cantidadProducto(Producto producto) {
    try {
      // Busca la relación del producto en el carrito
      final relation = _carritoProductos.firstWhere((cp) => cp.productoId == producto.id);
      return relation.cantidad;
    } catch (e) {
      // Si no se encuentra la relación, imprime un mensaje de error y retorna 0
      print("Relación no encontrada para el producto con ID: ${producto.id}. Error: $e");
      return 0;
    }
  }




  Future<void> loadCart(int carritoId) async {
  _isLoading = true;
  notifyListeners(); // Notifica que está cargando

  try {
    // Cargar relaciones de productos en carrito
    _carritoProductos = await _carritoService.getCarritoProductos(carritoId);

    // Si no hay productos en el carrito, manejar el caso
    if (_carritoProductos.isEmpty) {
      print("No hay productos en el carrito con ID: $carritoId");
      return;
    }

    // Cargar productos a partir de las relaciones
    _productosEnCarrito = await _carritoService.getProductosFromRelations(_carritoProductos);

    print("Productos en el carrito: $_productosEnCarrito");
  } catch (e) {
    print("Error al cargar el carrito: $e");
  } finally {
    _isLoading = false;
    notifyListeners(); // Notifica el fin de la carga
  }
}



  // Método para añadir un producto al carrito
  Future<void> addProductToCart(Producto producto, int cantidad) async {
    final carritoId = _carritoProductos.isNotEmpty ? _carritoProductos.first.carritoId : 1;
    await _carritoService.addProductToCart(carritoId, producto.id, cantidad);
    await loadCart(carritoId); // Recargar el carrito para reflejar cambios
  }

  // Método para disminuir la cantidad de un producto
  Future<void> decreaseProductQuantity(Producto producto) async {
    final carritoId = _carritoProductos.isNotEmpty ? _carritoProductos.first.carritoId : 1;
    final existingProductIndex = _productosEnCarrito.indexWhere((p) => p.id == producto.id);
    if (existingProductIndex != -1) {
      if (_carritoProductos[existingProductIndex].cantidad > 1) {
        await _carritoService.updateCantidadProducto(carritoId, producto.id, _carritoProductos[existingProductIndex].cantidad - 1);
      } else {
        await _carritoService.removeProductFromCart(carritoId, producto.id);
      }
      await loadCart(carritoId); // Recargar el carrito para reflejar cambios
    }
  }
    //Método para eliminar un producto completamente del carrito
  Future<void> removeProductFromCart(Producto producto) async {
    final carritoId = _carritoProductos.isNotEmpty ? _carritoProductos.first.carritoId : 1;
    try {
      // 1. Remover la relación `CarritoProducto` del servicio y localmente
      await _carritoService.removeProductFromCart(carritoId, producto.id);

      // 2. Actualizar el estado localmente
      _carritoProductos.removeWhere((cp) => cp.productoId == producto.id);
      _productosEnCarrito.removeWhere((p) => p.id == producto.id);

      notifyListeners();
    } catch (e) {
      print("Error al eliminar el producto del carrito: $e");
    }
  }

  // Método para vaciar el carrito
  Future<void> clearCart() async {
    _productosEnCarrito.clear();
    _carritoProductos.clear();
    await _carritoService.saveCarritoProductosToFile();
    notifyListeners();
  }
  Future<void> placeOrder(BuildContext context) async {
  if (_carritoProductos.isNotEmpty && _productosEnCarrito.isNotEmpty) {
    try {
      // 1. Validar si hay productos en el carrito
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);

      // 2. Crear una lista de IDs de los productos en el carrito
      final productIds = _carritoProductos.map((cp) => cp.productoId).toList();

      // 3. Crear el pedido usando el OrderProvider
      await orderProvider.agregarPedidoConProductos(
        _carritoProductos.first.carritoId, // ID del carrito
        productIds, // Lista de IDs de los productos
      );

      // 4. Vaciar el carrito después de colocar el pedido
      await clearCart();
      notifyListeners();
    } catch (e) {
      print("Error al colocar el pedido: $e");
    }
  } else {
    print("No hay productos en el carrito para realizar un pedido.");
  }
}

  initializeCart(Carrito carritoPrueba) {}


}


