import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jewelry_app/components/buttons/custom_elevated_buttom.dart';

class RightDrawer extends StatelessWidget {
  const RightDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(30),
        children: <Widget>[
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.tab_sharp,
                color: Color.fromRGBO(0, 122, 255, 1),
              ),
              SizedBox(height: 10),
              Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ListTile(
            leading: const Icon(FontAwesomeIcons.person),
            title: const Text('Men'),
            onTap: () {
              // Navega a la página de Men
              Navigator.pushNamed(context, '/men');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.ring),
            title: const Text('Rings'),
            onTap: () {
              // Navega a la página de Rings
              Navigator.pushNamed(context, '/rings');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.solidCircle),
            title: const Text('Earrings'),
            onTap: () {
              // Navega a la página de Earrings
              Navigator.pushNamed(context, '/earrings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.watch),
            title: const Text('Bracelets'),
            onTap: () {
              // Navega a la página de Bracelets
              Navigator.pushNamed(context, '/bracelets');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.gem),
            title: const Text('Necklaces'),
            onTap: () {
              // Navega a la página de Necklaces
              Navigator.pushNamed(context, '/necklaces');
            },
          ),
          const SizedBox(height: 40),
          CustomElevatedButtom(
            onPressed: () {
              Navigator.pushNamed(context, "/home");
            },
            message: "About us",
          ),
        ],
      ),
    );
  }
}
