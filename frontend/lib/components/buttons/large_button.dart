import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class LargeButton extends StatelessWidget {
  final String titulo;
  final VoidCallback onPressed;
  
  const LargeButton({super.key, required this.titulo, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.thirdColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 60,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
  }
}