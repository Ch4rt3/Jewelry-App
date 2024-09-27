import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

   Widget _buildBody(BuildContext context) {
    return MainBackground(
        children: [Text("Hola mundo")],
      );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    );
  }
}