import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  Usuario _usuario = Usuario(
    email: "",
    url: "",
    descripcion: "",
    acercaDe: "",
    imagen: "",
    nombre: "",
    telefono: "",
    visibilidad: true,
    contrasena: "",
  ); // Usuario actualmente logueado
  bool _isLogged = false; // Atributo para verificar si el usuario está logueado
  String? _userId; // Variable para almacenar el ID del usuario

  // Getters
  Usuario? get usuario => _usuario;
  bool get isLogged => _isLogged;
  String? get userId => _userId; // Getter para acceder al ID del usuario

  // Método para actualizar la información del usuario
  Future<void> actualizarUsuario(String nombre, String email, String contrasena) async {
    try {
      final response = await UsuarioService().updateUsuario({
        'id': _usuario.id, // Asegúrate de que el modelo Usuario tenga un campo 'id'
        'Nombre': nombre,
        'Email': email,
        'Contrasenia': contrasena,
      });

      if (response.statusCode == 200) {
        // Actualiza el estado local del usuario si la solicitud es exitosa
        _usuario.nombre = nombre;
        _usuario.email = email;
        _usuario.contrasena = contrasena;
        notifyListeners();
      } else {
        print('Error al actualizar la información: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al actualizar el usuario: $e');
    }
  }

  // Método para autenticar al usuario y guardar el ID en SharedPreferences
  Future<bool> login(String email, String password) async {
    try {
      final response = await UsuarioService().loginUsuario(email, password);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Acceder al usuario y token de la respuesta
        Map<String, dynamic> usuarioData = data['usuario'];

        // Crear un usuario desde los datos recibidos
        _usuario = Usuario.fromJson(usuarioData);
        _userId = _usuario.id.toString(); // Guarda el ID del usuario

        // Guardar el ID en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', _userId!);

        _isLogged = true;

        print('Usuario logueado: $_usuario');
        print('ID guardado: $_userId');

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

// Método para cargar el ID desde SharedPreferences
Future<void> loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  _userId = prefs.getString('userId');
  notifyListeners();
}


  // Método para cerrar sesión y limpiar el ID de SharedPreferences
  void logout() async {
    _usuario = Usuario(
      email: "",
      url: "",
      descripcion: "",
      acercaDe: "",
      imagen: "",
      nombre: "",
      telefono: "",
      visibilidad: true,
      contrasena: "",
    );
    _isLogged = false;
    _userId = null;

    // Eliminar el ID de SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');

    notifyListeners();
  }

  void setUser(Usuario usuario) {
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

