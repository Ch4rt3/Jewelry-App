import 'package:flutter/material.dart';

class LargeTextFormField extends StatelessWidget {
  final String titulo;
  final Function onPressed;
  const LargeTextFormField({super.key, required this.titulo, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}