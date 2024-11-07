import 'package:flutter/material.dart';

class LargeTextFormField extends StatefulWidget {
  final String titulo;
  final TextEditingController? controller;
  final Function(String) onChanged;
  final bool isPassword; // Nuevo parámetro para indicar si es un campo de contraseña

  const LargeTextFormField({
    super.key,
    required this.titulo,
    this.controller,
    required this.onChanged,
    this.isPassword = false, // Valor predeterminado es false
  });

  @override
  _LargeTextFormFieldState createState() => _LargeTextFormFieldState();
}

class _LargeTextFormFieldState extends State<LargeTextFormField> {
  bool _obscureText = true; // Estado para controlar la visibilidad del texto

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.titulo,
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
        suffixIcon: widget.isPassword // Solo mostrar el icono si es un campo de contraseña
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Alternar la visibilidad
                  });
                },
              )
            : null, // Si no es contraseña, no mostrar icono
      ),
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? _obscureText : false, // Controlar si debe ser oculto
    );
  }
}
