import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  Usuario? _usuario; // Usuario actualmente logueado
  bool _isLogged = false; // Atributo para verificar si el usuario está logueado
  List<Usuario> _usuarios = []; // Lista de usuarios cargados

  // Getters
  Usuario? get usuario => _usuario;
  bool get isLogged => _isLogged;
  List<Usuario> get usuarios => _usuarios;

  // Método para cargar todos los usuarios al iniciar la app
  Future<void> loadUsuarios() async {
    _usuarios = await UsuarioService().fetchAllUsuarios();
    notifyListeners(); // Notifica a los listeners que la data ha cambiado
  }

  // Método para autenticar al usuario
  Future<void> login(String email, String password) async {
    try {
      Usuario foundUser = _usuarios.firstWhere(
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

  // Método para registrar un nuevo usuario
  void register(Usuario newUser) {
    _usuarios.add(newUser); // Agrega el nuevo usuario a la lista
    _usuario = newUser; // Establece el nuevo usuario como el logueado
    _isLogged = true;
    notifyListeners();
  }

  // Método para cerrar sesión
  void logout() {
    _usuario = null;
    _isLogged = false;
    notifyListeners();
  }

  // Método para actualizar la contraseña del usuario logueado
  void updatePassword(String newPassword) {
    if (_usuario != null) {
      _usuario!.contrasena = newPassword; // Actualiza la contraseña
      notifyListeners(); // Notifica a los oyentes
    }
  }
}
