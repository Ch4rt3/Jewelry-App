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

  // Método para agregar un nuevo usuario
  Future<bool> addUser(Usuario newUser) async {
    try {
      final String response = await rootBundle.loadString('assets/json/usuarios.json');
      List<dynamic> data = jsonDecode(response);

      data.add(newUser.toJson());

      // Aquí se debería guardar la nueva lista en el archivo o enviarla a un backend

      return true;  // Retorna true si la operación fue exitosa
    } catch (e) {
      print('Error al agregar usuario: $e');
      return false;
    }
  }

  // Método para actualizar la contraseña de un usuario
  Future<bool> updatePassword(String email, String newPassword) async {
    try {
      List<Usuario> usuarios = await fetchAllUsuarios();

      // Buscar el usuario por email, si no existe, devolvemos false
      bool emailExists = usuarios.any((user) => user.email == email);

      if (emailExists) {
        Usuario userToUpdate = usuarios.firstWhere((user) => user.email == email);

        userToUpdate.contrasena = newPassword; // Asumiendo que la clase Usuario tiene un atributo contrasena

        // Convertir la lista actualizada a JSON
        List<Map<String, dynamic>> updatedData = usuarios.map((user) => user.toJson()).toList();

        // Aquí deberías guardar la nueva lista en el archivo o enviarla a un backend

        return true; // Retorna true si la operación fue exitosa
      } else {
        print("Usuario con email $email no encontrado");
        return false; // Retorna false si el usuario no existe
      }
    } catch (e) {
      print("Error al actualizar la contraseña: $e");
      return false; // Retorna false en caso de error
    }
  }
}
