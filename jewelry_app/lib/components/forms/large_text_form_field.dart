import 'package:flutter/material.dart';

class LargeTextFormField extends StatelessWidget {
  final String titulo;
  final TextEditingController? controller;
  final Function(String) onChanged;
  final bool isPassword; // Nuevo parámetro

  const LargeTextFormField({
    super.key,
    required this.titulo,
    this.controller,
    required this.onChanged,
    this.isPassword = false, // Valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword, // Usar el parámetro para ocultar el texto
      decoration: InputDecoration(
        hintText: titulo,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
