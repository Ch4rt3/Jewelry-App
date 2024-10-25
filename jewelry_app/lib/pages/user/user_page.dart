import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navegar hacia atrás
          },
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Acción de más opciones
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTMqcCXSPd1GayrYoUaN2o4vaBaiZCOa7v7Q&s', // URL del avatar
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Robert Fox',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'robertfox@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                      // Acción de ir a ajustes
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list_alt, color: Colors.black),
                    title: const Text('Orders'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, '/orders');
                      // Acción de ir a órdenes
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.black),
                    title: const Text('Shipping Addresses'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                        Navigator.pushNamed(context, '/address');
                      // Acción de ir a direcciones
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet,
                        color: Colors.black),
                    title: const Text('Wallet'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                       Navigator.pushNamed(context, '/wallet');
                      // Acción de ir a billetera
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text('Log out'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                       Navigator.pushNamed(context, '/sign-in');
                      // Acción de cerrar sesión
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}