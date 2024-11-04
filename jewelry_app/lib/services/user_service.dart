import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/api_base_service.dart';

class UsuarioService extends ApiBaseService{
  
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

  Future<http.Response> loginUsuario(String email, String contrasena) async {
  // Crear el cuerpo de la solicitud con las credenciales
    Map<String, dynamic> data = {
      'email': email,
      'contrasenia': contrasena
    };

    // Realizar la solicitud POST al endpoint de login
    final response = await postRequest('/usuarios/login', data);

    // Imprimir la respuesta para depuración
    print('Response: ${response.body}');

    // Retornar la respuesta para manejarla en otra parte del código si es necesario
    return response;
  }

  Future<http.Response> crearUsuario(Usuario usuario) async {
    // Convertir el objeto Usuario a un mapa para el cuerpo de la solicitud
    Map<String, dynamic> data = usuario.toJson();

    // Realizar la solicitud POST al endpoint de creación de usuario
    final response = await postRequest('/usuarios', data);

    print(data);
    // Imprimir la respuesta para depuración
    print('Response: ${response.body}');

    // Retornar la respuesta para manejarla en otra parte del código si es necesario
    return response;
  }

}
