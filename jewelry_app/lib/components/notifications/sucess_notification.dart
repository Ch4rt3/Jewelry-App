import 'package:flutter/material.dart';
import 'package:jewelry_app/components/buttons/custom_elevated_buttom.dart';
import 'package:jewelry_app/configs/colors.dart';
import 'package:lottie/lottie.dart';

class SuccessNotification extends StatefulWidget {
  final String message;
  final VoidCallback action;

  const SuccessNotification({super.key, required this.message, required this.action});

  @override
  SuccessNotificationState createState() => SuccessNotificationState();
}

class SuccessNotificationState extends State<SuccessNotification> {
  bool _isAnimationCompleted = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isAnimationCompleted)
              Lottie.asset(
                'public/green_check.json', // Ruta del archivo de animación Lottie
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                repeat: false, // Se reproduce solo una vez
                onLoaded: (composition) {
                  Future.delayed(composition.duration, () {
                    setState(() {
                      _isAnimationCompleted = true;
                    });
                  });
                },
              ),
            if (_isAnimationCompleted)
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 150,
              ),
            const SizedBox(height: 30),
            // Texto de éxito
            const Text(
              'Congrats!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            // Mensaje de confirmación
            Text(
              widget.message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 80),
            // Botón de continuar
            CustomElevatedButtom(
              message: "Continue", 
              onPressed: widget.action ,
            ),
          ],
        ),
      ),
    );
  }
}
