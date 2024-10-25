import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/user_service.dart';

class ForgotPasswordController {
  final TextEditingController emailController = TextEditingController();

  Future<Map<String, dynamic>?> sendResetCode(BuildContext context) async {
  String email = emailController.text;

  try {
    List<Usuario> data = await UsuarioService().fetchAllUsuarios();
    bool emailExists = data.any((user) => user.email == email);

    if (!emailExists) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este correo no está registrado'),
          ),
        );
      }
      return null; // Retorna null si el correo no está registrado
    } else {
      Random random = Random();
      int resetCode = random.nextInt(9000) + 1000;
      return {'email': email, 'resetCode': resetCode};
    }
  } catch (e) {
    print("Error al enviar el código: $e");
    return null; // Retorna null en caso de error
  }
}
}
