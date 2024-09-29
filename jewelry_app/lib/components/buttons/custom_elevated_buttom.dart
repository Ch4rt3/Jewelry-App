import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class CustomElevatedButtom extends StatelessWidget {
  final String message;
  final Function onPressed;

  const CustomElevatedButtom({super.key, required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: () {
                onPressed;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.thirdColor, // Color de fondo
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
  }
}