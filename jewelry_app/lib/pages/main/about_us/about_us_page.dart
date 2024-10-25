import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // imagen
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('public/anillo_oro.png'), // Imagen desde la carpeta public
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 16),


              // Título principal
              Text(
                'Discover The Hidden Treasures of Peru',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),


              // Descripción de la joyería
              Text(
                'Born in 2010, our jewelry transcends boundaries, blending heritage and modern touches from the heart of Peru. Explore earrings, rings, and necklaces meticulously crafted from Silver 950 and 18k gold. Welcome to Guaywarmi Jewelry.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),


              // Botón de Shop
              ElevatedButton(
                onPressed: () {
                  print("Shop button pressed");
                },
                child: Text('Shop'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 16),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Address:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Vancouver, BC",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),


                  Row(
                    children: <Widget>[
                      Icon(Icons.phone, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Phone:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "250-234-1080",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),


                  Row(
                    children: <Widget>[
                      Icon(Icons.email, size: 24),
                      SizedBox(width: 8),
                      Text(
                        "Email:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    "naomischick@gmail.com",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 32),


                  // Íconos de facebook e ig
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebook),
                        onPressed: () {
                          print("Facebook icon pressed");
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.instagram),
                        onPressed: () {
                          print("Instagram icon pressed");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
