import 'package:flutter/material.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Lógica de autenticación
  void signIn(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    // Simular autenticación
    if (email.isNotEmpty && password.isNotEmpty) {
      // Obtener el UserProvider para manejar el estado del usuario
      print(email);
      print(password);
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      // Intentar el login con el método del UserProvider
      userProvider.login(email, password);

      if (userProvider.isLogged) {
        // Navegar al HomePage después del login exitoso
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Mostrar un diálogo de error si las credenciales son incorrectas
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Credenciales incorrectas'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Mostrar mensaje si faltan campos por completar
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Por favor, complete todos los campos'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
