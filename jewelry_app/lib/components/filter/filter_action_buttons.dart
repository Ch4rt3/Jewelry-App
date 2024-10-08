import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onReset; // Función para manejar el reset
  final VoidCallback onApply; // Función para manejar el apply

  const ActionButtons({
    super.key,
    required this.onReset,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Botón Reset alineado a la izquierda
        TextButton(
          onPressed: onReset, // Llamamos a la función de reset
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Aumentar padding
            backgroundColor: Colors.grey[300], // Color de fondo gris
            minimumSize: const Size(140, 50), // Aumentar el tamaño mínimo
          ),
          child: const Text(
            'Reset',
            style: TextStyle(color: Colors.black, fontSize: 18), // Tamaño de fuente aumentado
          ),
        ),
        // Botón Apply alineado a la derecha
        ElevatedButton(
          onPressed: onApply, // Llamamos a la función de apply
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Aumentar padding
            backgroundColor: Colors.black, // Color personalizado
            minimumSize: const Size(140, 50), // Aumentar el tamaño mínimo
          ),
          child: const Text(
            'Apply',
            style: TextStyle(color: Colors.white, fontSize: 18), // Color blanco
          ),
        ),
      ],
    );
  }
}
