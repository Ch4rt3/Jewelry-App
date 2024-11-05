import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/auth_background.dart';
import 'package:jewelry_app/components/buttons/large_button.dart';
import 'package:jewelry_app/components/forms/large_text_form_field.dart';
import 'package:jewelry_app/components/auth/sign_in_with_account.dart';
import 'package:jewelry_app/components/messages/error_dialog.dart';
import 'package:jewelry_app/configs/colors.dart';
import 'package:jewelry_app/pages/auth/reset/forgot_password/forgot_password_controller.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  Widget _buildBody(BuildContext context) {
    final forgetPasswordController = ForgotPasswordController();

    return AuthBackground(
      titulo: "Forget Password",
      children: [
        const SizedBox(height: 30),
        LargeTextFormField(
          titulo: "Your email",
          controller: forgetPasswordController.emailController,
          onChanged: (value) {},
        ),
        const SizedBox(height: 50),
        LargeButton(
          titulo: "Send Email",
          onPressed: () async {
            // Llamar a la función que envía el correo y obtener el mensaje de respuesta
            Map<String, dynamic> resetCodeData = await forgetPasswordController.sendCode(context);
            String message = resetCodeData['message'];
            String email = resetCodeData['email'];

            // Mostrar el mensaje usando showErrorMessage

            // Si el mensaje es el esperado, esperar y navegar a la nueva página
            if (message == "Código de recuperación enviado a tu correo") {
              await Future.delayed(const Duration(seconds: 1)); // Esperar 1 segundo
              if(context.mounted){
                Navigator.pushNamed(context, "/recovery-password", arguments: {"email": email});
              }
            }
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
