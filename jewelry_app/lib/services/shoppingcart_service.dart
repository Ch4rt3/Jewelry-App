import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:jewelry_app/models/carrito.dart';

import '../models/producto.dart';
import '../models/carrito_producto.dart';

class CarritoService {
  // Listas para almacenar las relaciones y productos
  List<CarritoProducto> _carritoProductos = [];
  List<Producto> _productos = [];

  Future<List<Producto>> loadCarritoProductos(Map carrito) async {
  try {
    final String response = await rootBundle.loadString("assets/json/productos.json");
    final List<dynamic> data = jsonDecode(response);
    
    // Convierte los productos a objetos de tipo Producto
    List<Producto> productos = data.map((item) => Producto.fromJson(item)).toList();
    
    // Obtiene la lista de IDs de productos en el carrito
    List<int> listaProductos = List<int>.from(carrito['productos']);
    
    // Filtra los productos que coincidan con los IDs en listaProductos
    List<Producto> productosFiltrados = productos.where((producto) => listaProductos.contains(producto.id)).toList();
    
    print(productosFiltrados);
    return productosFiltrados;
  } catch (e) {
    print("Error al cargar los productos del carrito: $e");
    return [];
  }
}

  Future<Map> loadCarrito(int idCarrito) async {
  try {
    final String response = await rootBundle.loadString("assets/json/carritos.json");
    final List<dynamic> data = jsonDecode(response);

    // Buscar el carrito con el id especificado
    final carritoMap = data.firstWhere(
      (carrito) => carrito['id'] == idCarrito,
      orElse: () => {'mensaje':'Elemento no encontrado'}
    );

    // Si no se encontró el carrito, lanza una excepción
    if (carritoMap.containsKey('mensaje')) {
      throw Exception('Carrito no encontrado');
    }

    return carritoMap;

  } catch (e) {
    print("Error al cargar el carrito: $e");
    throw Exception('Error al cargar el carrito');
  }
}

  // Cargar productos desde el archivo JSON
  Future<void> loadProductosFromFile() async {
    try {
      final file = File('assets/json/productos.json');
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonString);
      _productos = jsonData.map((item) => Producto.fromJson(item)).toList();
    } catch (e) {
      print("Error al cargar productos del archivo: $e");
    }
  }

  // Cargar relaciones de carrito desde el archivo JSON
  Future<void> loadCarritoProductosFromFile() async {
    try {
      final file = File('assets/json/carritoProductos.json');
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonString);
      _carritoProductos = jsonData.map((item) => CarritoProducto.fromJson(item)).toList();
    } catch (e) {
      print("Error al cargar productos del carrito del archivo: $e");
    }
  }

  // Obtener las relaciones de carrito basadas en el carritoId
  Future<List<CarritoProducto>> getCarritoProductos(int carritoId) async {
    await loadCarritoProductosFromFile();
    return _carritoProductos.where((cp) => cp.carritoId == carritoId).toList();
  }

  // Obtener productos basados en las relaciones
  Future<List<Producto>> getProductosFromRelations(List<CarritoProducto> relaciones) async {
    await loadProductosFromFile();
    return relaciones
        .map((relacion) => _productos.firstWhere(
              (producto) => producto.id == relacion.productoId,
              orElse: () => Producto(
                id: 0,
                nombre: "Producto no encontrado",
                precio: 0,
                stock: 0,
                categoria: "Desconocida",
                imagenUrl: "assets/images/no-image.png",
                descripcion: "Descripción no disponible"
              ),
            ))
        .toList();
  }

  // Actualizar la cantidad de un producto en el carrito
  Future<void> updateCantidadProducto(int carritoId, int productoId, int nuevaCantidad) async {
    final index = _carritoProductos.indexWhere((cp) => cp.carritoId == carritoId && cp.productoId == productoId);
    if (index != -1) {
      _carritoProductos[index].cantidad = nuevaCantidad;
      await saveCarritoProductosToFile();
    } else {
      print("Relación no encontrada en el carrito para actualizar la cantidad.");
    }
  }

  // Eliminar un producto del carrito
  Future<void> removeProductFromCart(int carritoId, int productoId) async {
    _carritoProductos.removeWhere((cp) => cp.carritoId == carritoId && cp.productoId == productoId);
    await saveCarritoProductosToFile();
  }

  // Método para guardar las relaciones de carrito en el archivo JSON
  Future<void> saveCarritoProductosToFile() async {
    try {
      final jsonString = jsonEncode(_carritoProductos.map((cp) => cp.toJson()).toList());
      final file = File('assets/json/carritoProductos.json');
      await file.writeAsString(jsonString);
    } catch (e) {
      print("Error al guardar las relaciones en el archivo JSON: $e");
    }
  }

  // Método para agregar un nuevo producto al carrito
  Future<void> addProductToCart(int carritoId, int productoId, int cantidad) async {
    final existingRelation = _carritoProductos.firstWhere(
      (cp) => cp.carritoId == carritoId && cp.productoId == productoId,
      orElse: () => CarritoProducto(id: _carritoProductos.length + 1, carritoId: carritoId, productoId: productoId, cantidad: 0),
    );
    existingRelation.cantidad += cantidad;
    await saveCarritoProductosToFile();
  }
}



