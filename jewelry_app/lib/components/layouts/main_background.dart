import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class MainBackground extends StatelessWidget {
  final List<Widget> children;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainBackground({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(Icons.diamond, color: Colors.black),
            SizedBox(width: 8),
            Text("Hello, User", style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer(); // Abre el sidebar desde la derecha
            },
          ),
        ],
      ),
      endDrawer: Drawer( // Sidebar que aparece desde la derecha
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Men'),
              onTap: () {
                // Acción cuando se presiona
              },
            ),
            ListTile(
              leading: Icon(Icons.shop_2),
              title: Text('Rings'),
              onTap: () {
                // Acción cuando se presiona
              },
            ),
            ListTile(
              leading: Icon(Icons.shop_2_outlined),
              title: Text('Earrings'),
              onTap: () {
                // Acción cuando se presiona
              },
            ),
            ListTile(
              leading: Icon(Icons.access_alarm),
              title: Text('Bracelets'),
              onTap: () {
                // Acción cuando se presiona
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Necklaces'),
              onTap: () {
                // Acción cuando se presiona
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: AppColors.primaryColor,
              child: Column(
                children: children,
              ),
            ) 
          ),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
        ],
      ),
    );
  }
}