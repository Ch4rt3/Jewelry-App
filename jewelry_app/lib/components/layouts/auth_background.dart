
import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class AuthBackground extends StatelessWidget {
  final List<Widget> children;
  final String titulo;
  
  const AuthBackground({super.key, required this.titulo, required this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenHeight = constraints.maxHeight;
      
          return Stack(
            children: [
              Container(
                color: AppColors.backgroundLogin,
                height: screenHeight,
              ),
              Positioned(
                top: screenHeight / 4,
                left: 0,
                right: 0,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    height: screenHeight,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox( height: 35 ),
                            Text(
                              titulo,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                            ),
                            const SizedBox( height: 20 ),
                            ...children,
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ],
          );
        },
      ),
    );
  }
}