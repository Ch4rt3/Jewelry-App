import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

   Widget _buildBody(BuildContext context) {
    return const MainBackground(
          message: "Hello, User",
          body: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: 10,),
                  Text(
                    "Best jewelry\nfor you",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                    textWidthBasis: TextWidthBasis.longestLine,
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Aquí puede ir el contenido de tu página
            ],
          ),
        ), showDiamondMessage: true,
    );
   }
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}