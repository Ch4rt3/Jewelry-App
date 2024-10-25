import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/auth_background.dart';
import 'package:jewelry_app/components/buttons/large_button.dart';
import 'package:jewelry_app/components/forms/large_text_form_field.dart';
import 'package:jewelry_app/components/auth/sign_in_with_account.dart';
import 'package:jewelry_app/pages/auth/reset/forgot_password/forgot_password_controller.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  Widget _buildBody(BuildContext context) {
    final forgetPasswordController = ForgotPasswordController();

    return AuthBackground(
      titulo: "Forget Password", 
      children: [
        const SizedBox(height: 30,),
        LargeTextFormField(
          titulo: "Your email", 
          controller: forgetPasswordController.emailController,
          onChanged: (value) {}
        ),
        const SizedBox(height: 50),
        LargeButton(
          titulo: "Send Email", 
          onPressed: () async {
            Map<String, dynamic>? resetCodeData = await forgetPasswordController.sendResetCode(context);

            if (resetCodeData != null) {
              String resetCode = resetCodeData['resetCode']?.toString() ?? ''; // Extrae solo el resetCode

              if (context.mounted) { // Verifica si el contexto está montado
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Reset Code"),
                      content: Text(resetCode), // Muestra solo el resetCode
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Pasar solo el código a la siguiente página
                            Navigator.pushNamed(context, "/recovery-password", arguments: {'email': forgetPasswordController.emailController.text, 'resetCode': resetCode}); 
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            }
          }
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
