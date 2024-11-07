import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jewelry_app/components/layouts/auth_background.dart';
import 'package:jewelry_app/components/buttons/large_button.dart';
import 'package:jewelry_app/components/forms/large_text_form_field.dart';
import 'package:jewelry_app/configs/colors.dart';
import 'package:jewelry_app/pages/auth/sign_in/sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController signInController = SignInController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: AuthBackground(
        titulo: "Inicio de sesión",
        children: [
          LargeTextFormField(
            titulo: "Correo electrónico",
            controller: signInController.emailController,
            onChanged: (value) {
              // Aquí puedes manejar cambios si es necesario
            },
          ),
          const SizedBox(height: 20),
          LargeTextFormField(
            titulo: "Contraseña",
            controller: signInController.passwordController,
            isPassword: true,
            onChanged: (value) {
              // Aquí puedes manejar cambios si es necesario
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Acción para recuperar contraseña
                Navigator.pushNamed(context, "/forgot-password");
              },
              child: const Text(
                '¿Olvidó su contraseña?',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 10),
          LargeButton(
            titulo: "INGRESAR",
            onPressed: () {
              // Llama al método signIn del controlador al presionar el botón
              signInController.signIn(context);
            },
          ),
          const SizedBox(height: 10),
          // No tienes cuenta aún?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("¿No tienes una cuenta aún?"),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/sign-up");
                },
                child: const Text(
                  "Registrarse",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.google),
            iconSize: 50.0,
            onPressed: () {
              // Acción al presionar el botón
            },
          ),
        ],
      ),
    );
  }
}
