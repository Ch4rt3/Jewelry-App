import 'package:flutter/material.dart';
import 'package:jewelry_app/components/navigation/bottom_bar.dart';
import 'package:jewelry_app/components/navigation/diamond_app_bar.dart';
import 'package:jewelry_app/components/navigation/right_drawer.dart';

class MainBackground extends StatefulWidget {
  final Widget body;
  final bool showDiamondMessage;
  final String message;

  const MainBackground({
    super.key,
    required this.body, 
    required this.showDiamondMessage, 
    this.message = "",
  });

  @override
  // ignore: library_private_types_in_public_api
  _MainBackgroundState createState() => _MainBackgroundState();
}

class _MainBackgroundState extends State<MainBackground> {
  int currentIndex = 0; // Estado para el índice actual

  void _onBottomBarTapped(int index) {
    setState(() {
      currentIndex = index; // Actualiza el índice
      switch (index) {
      case 0:
        print("Inicio");
        break;
      case 1:
        print("Perfil");
        break;
      case 2:
        print("Carrito");
        break;
    }
    });

    // Aquí puedes navegar a otras páginas si lo deseas
  }

  

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: DiamondAppBar(
        showDiamond: widget.showDiamondMessage,
        screenHeight: screenHeight,
        message: widget.message,
      ),

      //Drawer a la derecha
      endDrawer: const RightDrawer(),

      //Cuerpo
      body: widget.body,

      //BottomBar
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        onTap: _onBottomBarTapped, // Pasa la función al BottomBar
      ),
    );
  }
}
