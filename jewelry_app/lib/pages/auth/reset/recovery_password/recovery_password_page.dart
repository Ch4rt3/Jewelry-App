import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/auth_background.dart';
import 'package:jewelry_app/components/buttons/large_button.dart';
import 'package:jewelry_app/components/forms/large_text_form_field.dart';
import 'package:jewelry_app/components/auth/sign_in_with_account.dart';
import 'package:jewelry_app/pages/auth/reset/recovery_password/recovery_password_controller.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  Widget _buildBody(BuildContext context) {
    // Crear una instancia del controlador
    final RecoveryPasswordController recoveryPasswordController = RecoveryPasswordController();
    
    // Obtener argumentos pasados a la página
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Obtener email de los argumentos
    String email = args?['email'] ?? '';
    
    // Obtener resetCode de los argumentos y convertirlo a String
    String resetCode = (args?['resetCode'] is int) ? args!['resetCode'].toString() : args?['resetCode'] ?? '';

    return AuthBackground(
      titulo: "Recovery Password", 
      children: [
        const SizedBox(height: 10,),
        LargeTextFormField(
          controller: recoveryPasswordController.resetCodeController,
          titulo: "Reset Code", 
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
        LargeTextFormField(
          controller: recoveryPasswordController.newPasswordController,
          titulo: "New Password", 
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
        LargeTextFormField(
          controller: recoveryPasswordController.confirmPasswordController,
          titulo: "Confirm Password", 
          onChanged: (value) {},
        ),
        const SizedBox(height: 20),
        LargeButton(
          titulo: "Change Password", 
          onPressed: () {
            // Llamar a changePassword con email y resetCode
            recoveryPasswordController.changePassword(context, email, resetCode); 
          },
        ),
        const SignInWithAccount(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}
