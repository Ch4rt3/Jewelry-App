import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  Usuario _usuario = Usuario(email: "", url: "", descripcion: "", acercaDe: "", imagen: "",nombre: "", telefono: "", visibilidad: true, contrasena: "", codigoRecuperacion: null); // Usuario actualmente logueado
  bool _isLogged = false; // Atributo para verificar si el usuario está logueado
  List<Usuario> _usuarios = []; // Lista de usuarios cargados

  // Getters
  Usuario? get usuario => _usuario;
  bool get isLogged => _isLogged;
  List<Usuario> get usuarios => _usuarios;



  // Método para autenticar al usuario
  Future<bool> login(String email, String password) async {
  try {
    // Llamar a la función loginUsuario para autenticar
    final response = await UsuarioService().loginUsuario(email, password);
    // Verificar si el login fue exitoso
    if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Acceder al usuario y token de la respuesta
        Map<String, dynamic> usuarioData = data['usuario'];

        // Crear un usuario desde los datos recibidos
        _usuario = Usuario.fromJson(usuarioData); 
        _isLogged = true;

        print(_usuario);

        notifyListeners(); // Notificar cambios en el estado
        return true;
      } else {
        // Si el código de estado no es 200, el login falló
        _isLogged = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Error en el login: $e');
      _isLogged = false;
      notifyListeners();
      return false;
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
    _usuario = Usuario(email: "", url: "", descripcion: "", acercaDe: "", imagen: "",nombre: "", telefono: "", visibilidad: true, contrasena: "", codigoRecuperacion: null);
    _isLogged = false;
    notifyListeners();
  }

  void setUser(Usuario usuario){
    _usuario = usuario;
    _isLogged = true;
    notifyListeners();
  }

  // Método para actualizar la contraseña del usuario logueado
  void updatePassword(String newPassword) {
    _usuario.contrasena = newPassword; // Actualiza la contraseña
    notifyListeners(); // Notifica a los oyentes
  }
}
