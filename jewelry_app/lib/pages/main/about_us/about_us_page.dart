import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      automaticallyImplyLeading: false,
      showDiamondMessage: true,
      message: "About us",
      searchBar: false,
      showComplementMessage: false,
      body: Text("AQUI COLOCAS TU CODIGO JEFF"),
    );
  }
}