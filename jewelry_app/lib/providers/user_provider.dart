import 'dart:convert'; // Importa para manejar JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importa para cargar archivos de assets
import 'package:jewelry_app/models/usuario.dart';

class UserProvider extends ChangeNotifier {
  Usuario? _usuario;
  bool _isLogged = false; // Atributo para verificar si el usuario está logueado

  // Getters
  Usuario? get usuario => _usuario;
  bool get isLogged => _isLogged;

  // Método para autenticar al usuario
  void login(String email, String password) async {
    try {
      // Lógica para encontrar al usuario en el archivo JSON
      var userList = await fetchUsersFromJson(); // Cambiado a async
      Usuario foundUser = userList.firstWhere(
        (user) => user.email == email && user.contrasena == password,
      );

      // Si el usuario es encontrado, lo asignamos y marcamos como logueado
      _usuario = foundUser;
      _isLogged = true;
      notifyListeners();
    } catch (e) {
      // Si no se encuentra el usuario, se maneja la excepción
      _isLogged = false;
      _usuario = null; // Aseguramos que no haya un usuario asignado
      notifyListeners();
    }
  }

  // Método para cerrar sesión
  void logout() {
    _usuario = null;
    _isLogged = false;
    notifyListeners();
  }

  // Método para cargar la lista de usuarios desde el JSON (simulación de base de datos)
  Future<List<Usuario>> fetchUsersFromJson() async {
    // Cargar el archivo JSON
    final String response = await rootBundle.loadString('assets/json/usuarios.json');
    // Decodificar el JSON a una lista de objetos Usuario
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Usuario.fromJson(json)).toList();
  }
}
