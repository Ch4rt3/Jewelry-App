import 'package:flutter/material.dart';
import 'package:jewelry_app/components/messages/error_dialog.dart';
import 'package:jewelry_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/user_provider.dart'; // Importa tu provider

class RecoveryPasswordController {
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> changePassword(BuildContext context, String email) async {
    String inputResetCode = resetCodeController.text.trim(); // Trim para evitar espacios en blanco
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    

    // Aquí debes verificar que resetCode sea un String válido
    if (inputResetCode.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      showErrorMessage(context, 'Por favor completa todos los campos');
      return; // Salir si algún campo está vacío
    }

    if (newPassword != confirmPassword) {
      showErrorMessage(context, 'Las contraseñas no coinciden');
      return;
    }

    try {
        Provider.of<UserProvider>(context, listen: false).updatePassword(newPassword);
        UsuarioService().actualizarContrasenia(email, newPassword, inputResetCode);
        
        // Navegar a la página de éxito
        Navigator.pushNamed(context, "/success-password");
    } catch (e) {
      print(e);
      showErrorMessage(context, 'Código de restablecimiento incorrecto');
    }

  }

}
