import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jewelry_app/models/usuario.dart';

class UsuarioService {
  Future<List<Usuario>> fetchAll() async {
    List<Usuario> usuarios = [];
    final String response = await rootBundle.loadString("assets/json/usuarios.json");
    final List<dynamic> data = jsonDecode(response);
    usuarios = data.map((map) => Usuario.fromJson(map as Map<String, dynamic>)).toList();
    return usuarios;
  }
}
