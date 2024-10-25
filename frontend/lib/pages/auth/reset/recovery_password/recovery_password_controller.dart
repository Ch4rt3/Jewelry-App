import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/user_provider.dart'; // Importa tu provider

class RecoveryPasswordController {
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> changePassword(BuildContext context, String email, String resetCode) async {
    String inputResetCode = resetCodeController.text.trim(); // Trim para evitar espacios en blanco
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Aquí debes verificar que resetCode sea un String válido
    if (inputResetCode.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog(context, 'Por favor completa todos los campos');
      return; // Salir si algún campo está vacío
    }

    if (inputResetCode == resetCode) {
      if (newPassword == confirmPassword) {
        // Actualizar la contraseña en el UserProvider
        Provider.of<UserProvider>(context, listen: false).updatePassword(newPassword);
        
        // Navegar a la página de éxito
        Navigator.pushNamed(context, "/success-password");
      } else {
        // Mostrar error de contraseña no coincide
        _showErrorDialog(context, 'Las contraseñas no coinciden');
      }
    } else {
      // Mostrar error de código incorrecto
      _showErrorDialog(context, 'Código de restablecimiento incorrecto');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}
