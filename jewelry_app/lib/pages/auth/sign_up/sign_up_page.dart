import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/auth_background.dart';
import 'package:jewelry_app/components/buttons/large_button.dart';
import 'package:jewelry_app/components/forms/large_text_form_field.dart';
import 'package:jewelry_app/components/auth/sign_in_with_account.dart';
import 'package:jewelry_app/pages/auth/sign_up/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Crear instancia del controlador solo para esta página
    final signUpController = SignUpController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: AuthBackground(
        titulo: "Registrarse",
        children: [
          LargeTextFormField(
            titulo: "Correo electrónico",
            controller: signUpController.emailController,
            onChanged: (value) => signUpController.setEmail(value),
          ),
          const SizedBox(height: 20),
          LargeTextFormField(
            titulo: "Contraseña",
            controller: signUpController.passwordController,
            onChanged: (value) => signUpController.setPassword(value),
          ),
          const SizedBox(height: 20),
          LargeTextFormField(
            titulo: "Confirmar contraseña",
            controller: signUpController.confirmPswrdController,
            onChanged: (value) => signUpController.setConfirmPassword(value),
          ),
          const SizedBox(height: 10),
          LargeButton(
            titulo: "REGISTRARSE",
            onPressed: () async {
              bool success = await signUpController.register(context);
              if (success) {
                // Verificar si el widget todavía está montado
                if (context.mounted) {
                  // Navegación al registro exitoso
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home', // Ruta a la que quieres navegar
                    (route) => false, // El predicado que elimina todas las rutas anteriores
                  );
                }
              } 
            },
          ),
          const SizedBox(height: 5),
          const SignInWithAccount(),
        ],
      ),
    );
  }
}
