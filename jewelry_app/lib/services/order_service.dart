import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jewelry_app/models/pedido.dart';

class PedidoService {
  Future<List<Pedido>> fetchAllPedidos() async {
    final String response = await rootBundle.loadString('json/pedidos.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Pedido.fromJson(json)).toList();
  }

  // Obtener pedidos de un usuario específico
  Future<List<Pedido>> getPedidosByUsuarioId(int usuarioId) async {
    List<Pedido> pedidos = await fetchAllPedidos();
    return pedidos.where((pedido) => pedido.usuarioId == usuarioId).toList();
  }
}
