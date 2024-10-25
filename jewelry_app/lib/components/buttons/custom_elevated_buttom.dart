import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;
  final ButtonStyle? style; // Estilo opcional para el botón
  final Color? textColor; // Color de texto opcional

  const CustomElevatedButton({
    super.key,
    required this.message,
    required this.onPressed,
    this.style, // Estilo opcional
    this.textColor, // Color de texto opcional
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ?? ElevatedButton.styleFrom( // Usa el estilo proporcionado o el predeterminado
        backgroundColor: AppColors.thirdColor, // Color de fondo predeterminado
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 60,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.white, // Usa el color proporcionado o blanco por defecto
        ),
      ),
    );
  }
}
