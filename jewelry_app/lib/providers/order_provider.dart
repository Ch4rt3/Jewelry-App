import 'package:flutter/material.dart';
import 'package:jewelry_app/models/pedido.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();
  List<Pedido> _pedidos = [];
  List<Producto> _productosEnPedido = [];

  List<Pedido> get pedidos => _pedidos;
  List<Producto> get productosEnPedido => _productosEnPedido;

  // Cargar pedidos del usuario y productos asociados
  Future<void> loadPedidos(int usuarioId) async {
    _pedidos = await _orderService.getPedidosByUsuarioId(usuarioId);
    notifyListeners();
  }

  // Obtener productos de un pedido específico
  Future<void> loadProductosForPedido(int pedidoId) async {
    _productosEnPedido = await _orderService.getProductosForPedido(pedidoId);
    notifyListeners();
  }

  // Crear un nuevo pedido con productos asociados
  Future<void> agregarPedidoConProductos(int usuarioId, List<int> productosIds) async {
    try {
      await _orderService.agregarPedidoConProductos(usuarioId, productosIds);
      loadPedidos(usuarioId);
    } catch (e) {
      print("Error al agregar pedido con productos: $e");
    }
  }
}

