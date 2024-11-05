import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String message) {
  // Verificar si el contexto es válido antes de mostrar el mensaje
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
