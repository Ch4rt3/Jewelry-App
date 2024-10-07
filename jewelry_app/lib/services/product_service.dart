import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jewelry_app/models/producto.dart';

class ProductoService {
  Future<List<Producto>> fetchAll() async {
    List<Producto> productos = [];
    final String response = await rootBundle.loadString("assets/json/productos.json");
    final List<dynamic> data = jsonDecode(response);
    productos = data.map((map) => Producto.fromJson(map as Map<String, dynamic>)).toList();
    return productos;
  }
}
