import 'package:flutter/material.dart';

class LargeTextFormField extends StatelessWidget {
  final String titulo;
  final TextEditingController? controller;
  final Function(String) onChanged;

  const LargeTextFormField({
    super.key,
    required this.titulo,
    this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
