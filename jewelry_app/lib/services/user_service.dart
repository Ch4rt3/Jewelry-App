import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jewelry_app/models/usuario.dart';

class UsuarioService {
  // Cargar todos los usuarios desde el JSON
  Future<List<Usuario>> fetchAllUsuarios() async {
  try {
    // Lee el archivo JSON
    String response = await rootBundle.loadString('assets/json/usuarios.json');
    
    // Imprime el JSON para verificar los datos
    print("Contenido del JSON: $response");
    
    // Decodifica y convierte a lista de usuarios
    List<dynamic> data = json.decode(response);
    print("Datos procesados: $data");
    
    List<Usuario> usuarios = data.map((item) => Usuario.fromJson(item)).toList();
    return usuarios;
  } catch (e) {
    print("Error al cargar usuarios: $e");
    return [];
  }
}

}

