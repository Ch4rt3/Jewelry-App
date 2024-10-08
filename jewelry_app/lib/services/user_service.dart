import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jewelry_app/models/usuario.dart';

class UsuarioService {
  Future<Usuario> getUsuarioById(int id) async {
    List<Usuario> usuarios = await fetchAllUsuarios();
    try {
      return usuarios.firstWhere((user) => user.id == id);
    } catch (e) {
      throw Exception("Usuario con ID $id no encontrado");
    }
  }

  // Método para obtener todos los usuarios
  Future<List<Usuario>> fetchAllUsuarios() async {
    final String response = await rootBundle.loadString("assets/json/usuarios.json");
    final List<dynamic> data = jsonDecode(response);
    return data.map((json) => Usuario.fromJson(json)).toList();
  }
}



