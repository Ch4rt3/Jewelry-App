import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jewelry_app/models/pedido.dart';
import 'package:jewelry_app/models/pedido_producto.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/services/product_service.dart';

class OrderService {
  final ProductService _productoService = ProductService();

  // Cargar todos los pedidos desde el JSON
  Future<List<Pedido>> fetchAllPedidos() async {
    try {
      final String response = await rootBundle.loadString('assets/json/pedidos.json');
      List<dynamic> data = jsonDecode(response);
      return data.map((json) => Pedido.fromJson(json)).toList();
    } catch (e) {
      print("Error al cargar pedidos: $e");
      return [];
    }
  }

  // Cargar todos los pedidos-productos desde la tabla intermedia
  Future<List<PedidoProducto>> fetchAllPedidoProductos() async {
    try {
      final String response = await rootBundle.loadString('assets/json/pedido_productos.json');
      List<dynamic> data = jsonDecode(response);
      return data.map((json) => PedidoProducto.fromJson(json)).toList();
    } catch (e) {
      print("Error al cargar PedidoProducto: $e");
      return [];
    }
  }

  // Obtener productos para un pedido específico usando la tabla intermedia
  Future<List<Producto>> getProductosForPedido(int pedidoId) async {
    try {
      List<PedidoProducto> pedidoProductos = await fetchAllPedidoProductos();

      // Filtra las relaciones por pedidoId
      List<PedidoProducto> relaciones = pedidoProductos.where((rel) => rel.pedidoId == pedidoId).toList();

      // Cargar todos los productos
      List<Producto> productos = await _productoService.fetchAllProducts();

      // Buscar los productos relacionados
      List<Producto> productosPedido = relaciones
          .map((relacion) => productos.firstWhere(
                (prod) => prod.id == relacion.productoId
              ))
          .toList();

      return productosPedido;
    } catch (e) {
      print("Error al obtener productos para el pedido con ID $pedidoId: $e");
      return [];
    }
  }

  // Obtener pedidos por usuario ID y cargar productos
  Future<List<Pedido>> getPedidosByUsuarioId(int usuarioId) async {
    try {
      List<Pedido> pedidos = await fetchAllPedidos();
      List<PedidoProducto> pedidoProductos = await fetchAllPedidoProductos();

      // Filtrar pedidos por usuarioId
      List<Pedido> pedidosUsuario = pedidos.where((pedido) => pedido.usuarioId == usuarioId).toList();

      // Cargar los productos para cada pedido
      for (var pedido in pedidosUsuario) {
        pedido.productosEnPedido = pedidoProductos.where((rel) => rel.pedidoId == pedido.id).toList();
      }

      return pedidosUsuario;
    } catch (e) {
      print("Error al obtener pedidos del usuario con ID $usuarioId: $e");
      return [];
    }
  }
  // Método para agregar un nuevo pedido con productos asociados a un usuario
Future<void> agregarPedidoConProductos(int usuarioId, List<int> productosIds) async {
  try {
    // Cargar todos los pedidos y la tabla intermedia de PedidoProducto
    List<Pedido> pedidos = await fetchAllPedidos();
    List<PedidoProducto> pedidoProductos = await fetchAllPedidoProductos();

    // Generar un nuevo ID de pedido
    int nuevoPedidoId = pedidos.length + 1;
    double montoTotal = 0.0;

    // Crear lista de productos usando el servicio de productos
    List<Producto> productos = await _productoService.fetchAllProducts();
    List<PedidoProducto> productosEnPedido = [];

    // Agregar cada producto a la relación intermedia y calcular el total
    for (int id in productosIds) {
      try {
        Producto producto = productos.firstWhere(
          (prod) => prod.id == id
        );

        montoTotal += producto.precio;

        // Crear la relación intermedia entre Pedido y Producto
        PedidoProducto nuevaRelacion = PedidoProducto(
          id: pedidoProductos.length + 1,
          pedidoId: nuevoPedidoId,
          productoId: id,
          cantidad: 1, // Ajustar si se necesita manejar cantidades
        );

        productosEnPedido.add(nuevaRelacion);
      } catch (e) {
        print("Error al buscar producto con ID: $id: $e");
      }
    }

    // Crear el nuevo pedido y agregarlo a la lista de pedidos
    Pedido nuevoPedido = Pedido(
      id: nuevoPedidoId,
      usuarioId: usuarioId,
      productosEnPedido: productosEnPedido,
      montoTotal: montoTotal,
      fecha: DateTime.now(),
    );

    pedidos.add(nuevoPedido);

    print("Pedido creado exitosamente para el usuario $usuarioId con los productos: $productosIds");
  } catch (e) {
    print("Error al agregar pedido para el usuario $usuarioId: $e");
  }
}
}

