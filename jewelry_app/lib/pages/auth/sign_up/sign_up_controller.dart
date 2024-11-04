import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/services/user_service.dart';
import 'package:provider/provider.dart';

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

  Future<bool> register(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false); // Cambiado aquí

    if (_email.isEmpty || _password.isEmpty || _confirmPassword.isEmpty) {
      _showErrorMessage(context, 'Los campos no pueden estar vacíos');
      return false; // Retorna false si hay campos vacíos
    }

    if (_password != _confirmPassword) {
      _showErrorMessage(context, 'Las contraseñas no coinciden');
      return false; // Las contraseñas no coinciden
    }

    try {
      Usuario newUser = Usuario(
        email: _email,
        contrasena: _password,
        nombre: "User",
        telefono: "", 
        url: "",
        descripcion: "",
        acercaDe: "",
        imagen: "",
        visibilidad: true,
      );

      await UsuarioService().crearUsuario(newUser);
      userProvider.setUser(newUser);
      return true;

    } catch (error) {
      print("Error al registrar usuario: $error");
      return false;
    }
  }


  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPswrdController.dispose();
  }
}
