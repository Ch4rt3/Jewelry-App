import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  Usuario _usuario = Usuario(
    id: null, // Inicializar el id como null o con un valor predeterminado si es necesario
    email: "",
    url: "",
    descripcion: "",
    acercaDe: "",
    imagen: "",
    nombre: "",
    telefono: "",
    visibilidad: true,
    contrasena: "",
    codigoRecuperacion: null,
  ); // Usuario actualmente logueado

  bool _isLogged = false; // Atributo para verificar si el usuario está logueado
  List<Usuario> _usuarios = []; // Lista de usuarios cargados

  // Getters
  Usuario? get usuario => _usuario;
  bool get isLogged => _isLogged;
  List<Usuario> get usuarios => _usuarios;

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

  // Método para autenticar al usuario
  Future<bool> login(String email, String password) async {
    try {
      final response = await UsuarioService().loginUsuario(email, password);
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
    _usuario = Usuario(
      id: null,
      email: "",
      url: "",
      descripcion: "",
      acercaDe: "",
      imagen: "",
      nombre: "",
      telefono: "",
      visibilidad: true,
      contrasena: "",
      codigoRecuperacion: null,
    );
    _isLogged = false;
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
