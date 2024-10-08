import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jewelry_app/models/carrito.dart';

class CarritoService {
  // Método para obtener todos los carritos
  Future<List<Carrito>> fetchAllCarritos() async {
    final String response = await rootBundle.loadString('json/carritos.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Carrito.fromJson(json)).toList();
  }

  // Método para obtener el carrito de un usuario específico
  Future<Carrito> getCarritoByUsuarioId(int usuarioId) async {
    List<Carrito> carritos = await fetchAllCarritos();
    try {
      return carritos.firstWhere((carrito) => carrito.usuarioId == usuarioId);
    } catch (e) {
      // Si no se encuentra el carrito, lanzamos una excepción
      throw Exception("No se encontró un carrito para el usuario con ID $usuarioId");
    }
  }
}

