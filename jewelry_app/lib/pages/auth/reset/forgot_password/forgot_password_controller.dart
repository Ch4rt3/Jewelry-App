import 'package:flutter/material.dart';
import 'package:jewelry_app/components/messages/error_dialog.dart';
import 'package:jewelry_app/services/user_service.dart';

class ForgotPasswordController {
  final TextEditingController emailController = TextEditingController();

  Future<Map<String, dynamic>> sendCode(BuildContext context) async {
    String email = emailController.text;

    final response = await UsuarioService().enviarCorreo(email);
    String message = response['message'].toString();

    // Check if the widget is mounted before showing the error message
    if (context.mounted) {
      showErrorMessage(context, message);
    }

    return {"email":email, "message": message}; 
  }

}
