import 'package:flutter/material.dart';
import 'package:jewelry_app/components/navigation/bottom_bar.dart';
import 'package:jewelry_app/components/navigation/diamond_app_bar.dart';
import 'package:jewelry_app/components/navigation/right_drawer.dart';
import 'package:jewelry_app/configs/colors.dart';

class MainBackground extends StatefulWidget {
  final Widget body;
  final bool showDiamondMessage;
  final bool showComplementMessage;
  final String message;
  final String subtitle;

  const MainBackground({
    super.key,
    required this.body, 
    required this.showDiamondMessage, 
    this.message = "", 
    required this.showComplementMessage, 
    this.subtitle = "",
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
         Navigator.pushNamed(context, '/user');
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
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.showComplementMessage ? const Row(
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
            )
            :
            Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.secondTextColor,
                letterSpacing: 1.5,
              ),
            ),
            
            const SizedBox(height: 20,),
            
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 10
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        
                      ),
                      onChanged: (value) {
                        // Lógica para filtrar resultados mientras el usuario escribe
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Borde redondeado
                      ),
                      side: const BorderSide(
                        color: Colors.black87, // Color del borde
                        width: 1, // Grosor del borde
                      ),
                      padding: const EdgeInsets.all(8), // Espacio alrededor del ícono
                    ),
                    onPressed: () {
                      // Acción del botón de filtro
                    },
                    child: const Icon(
                      Icons.filter_alt_outlined, // Icono de filtro
                      size: 40, // Tamaño del ícono
                      color: Colors.black87, // Color del ícono
                    ),
                  ),
                ],
              ),
            ),
            // Aquí puede ir el contenido de tu página
            widget.body,
          ],
        ),
      ),

      //BottomBar
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        onTap: _onBottomBarTapped, // Pasa la función al BottomBar
      ),
    );
  }
}
