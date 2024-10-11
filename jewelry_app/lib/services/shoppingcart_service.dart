import 'dart:convert';
import 'dart:io';
import '../models/producto.dart';
import '../models/carrito_producto.dart';

class CarritoService {
  // Listas para almacenar las relaciones y productos
  List<CarritoProducto> _carritoProductos = [];
  List<Producto> _productos = [];

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



