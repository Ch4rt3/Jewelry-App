import 'package:flutter/material.dart';
import 'package:jewelry_app/components/messages/error_dialog.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Lógica de autenticación
  void signIn(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    // Simular autenticación
    if (email.isNotEmpty && password.isNotEmpty) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      print(email);
      print(password);

      // Intentar el login con el método del UserProvider
      bool isLoggedIn = await userProvider.login(email, password); // Suponiendo que login retorna un bool

      if (isLoggedIn) {
        // Navegar al HomePage después del login exitoso
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home', // Ruta a la que quieres navegar
          (route) => false, // El predicado que elimina todas las rutas anteriores
        );
      } else {
        // Mostrar un diálogo de error si las credenciales son incorrectas
        showErrorMessage(context, 'Credenciales incorrectas'); // Use the new function
      }
    } else {
      // Mostrar mensaje si faltan campos por completar
      showErrorMessage(context, 'Por favor, complete todos los campos'); // Use the new function
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
