import 'package:flutter/material.dart';
import 'package:jewelry_app/components/filter/filter_modal_button.dart';
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
    required this.showComplementMessage,
    required this.message,  
    this.subtitle = "",
  });

  @override
  _MainBackgroundState createState() => _MainBackgroundState();
}

class _MainBackgroundState extends State<MainBackground> {
  int currentIndex = 0;  

  void _onBottomBarTapped(int index) {
    setState(() {
      currentIndex = index; 
      switch (index) {
        case 0:
          print("Inicio");
          Navigator.pushNamed(context, "/home");
          break;
        case 1:
          print("Perfil");
          Navigator.pushNamed(context, '/user');
          break;
        case 2:
          print("Carrito");
          Navigator.pushNamed(context, '/cart');
          break;
      }
    });
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

      endDrawer: const RightDrawer(),

      resizeToAvoidBottomInset: false,
      //Cuerpo
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
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
              
              const SizedBox(height: 20),
        
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      //Barra de busqueda
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    //Boton de filtro
                    const FilterModalButton(),
                  ],
                ),
              ),
              
              const SizedBox(height: 10),
        
        
              widget.body,
        
            ],
          ),
        ),
        ]
      ),

      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        onTap: _onBottomBarTapped, 
      ),
    );
  }
}

