import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

   Widget _buildBody(BuildContext context) {
    return const MainBackground(
          message: "Hello, User",
          body: Text("data"),
          showDiamondMessage: true, 
          showComplementMessage: true,
    );
   }
  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}