import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/services/user_service.dart';

class SignUpController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPswrdController = TextEditingController();

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  // Métodos para actualizar los valores del formulario
  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  // Método de registro
  Future<bool> register(BuildContext context, UserProvider userProvider) async {
    // Verificar si los campos están vacíos
    if (_email.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      _showErrorMessage(context, 'Los campos no pueden estar vacíos');
      return false; // Retorna false si hay campos vacíos
    }

    if (_password != _confirmPassword) {
      _showErrorMessage(context, 'Las contraseñas no coinciden');
      return false; // Las contraseñas no coinciden
    }

    try {
      // Cargar el archivo JSON existente de usuarios
      List<Usuario> data = await UsuarioService().fetchAllUsuarios();

      // Verificar si el correo ya está registrado
      bool emailExists = data.any((user) => user.email == _email); // Accede a la propiedad 'email'
      if (emailExists) {
        _showErrorMessage(context, 'El correo ya está registrado.');
        return false;
      }

      // Generar un ID único
      int newId = data.length + 1;

      // Crear el nuevo usuario
      Usuario newUser = Usuario(
        id: newId,
        email: _email,
        contrasena: _password,
        nombre: "User",
        telefono: "", 
        url: "",
        descripcion: "",
        acercaDe: "",
        imagen: "",
        visibilidad: true,
        pedidos: [],
      );

      // Usar el UserProvider para registrar el nuevo usuario
      userProvider.register(newUser);

      // Simular guardado del archivo JSON
      print("Usuario registrado exitosamente: ${newUser.toJson()}");

      // Aquí podrías implementar la lógica para enviar `data` actualizado a tu backend si tienes uno.

      return true;
    } catch (error) {
      print("Error al registrar usuario: $error");
      return false;
    }
  }

  void _showErrorMessage(BuildContext context, String message) {
    // Verificar si el contexto es válido antes de mostrar el diálogo
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPswrdController.dispose();
  }
}
