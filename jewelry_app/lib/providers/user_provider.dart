import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  Usuario? _usuario;
  bool _isLogged = false; // Atributo para verificar si el usuario está logueado

  // Getters
  Usuario? get usuario => _usuario;
  bool get isLogged => _isLogged;

  // Método para autenticar al usuario
  Future<void> login(String email, String password) async {
    try {
      // Lógica para encontrar al usuario en el archivo JSON
      var userList = await UsuarioService().fetchAllUsuarios(); // Cambiado a async
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

}
