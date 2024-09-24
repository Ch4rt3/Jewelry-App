import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jewelry_app/components/auth_background.dart';
import 'package:jewelry_app/components/large_button.dart';
import 'package:jewelry_app/components/large_text_form_field.dart';
import 'package:jewelry_app/configs/colors.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: AuthBackground( // Layout de las paginas de autenticacion
        titulo: "Inicio de sesión",
        children: [
          LargeTextFormField(
            titulo: "Correo electrónico", 
            onPressed: ()=>{},
          ),
          const SizedBox(height: 20),
          LargeTextFormField(
            titulo: "Contraseña", 
            onPressed: ()=>{},
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Acción para recuperar contraseña
              },
              child: const Text(
                '¿Olvidó su contraseña?',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 10),
          LargeButton(
            titulo: "INGRESAR", 
            onPressed: ()=>{}
          ),
          const SizedBox(height: 10),
          // No tienes cuenta aun?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("¿No tienes una cuenta aun?"),
              TextButton(
                onPressed: () {}, 
                child: const Text(
                        "Registrarse",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold
                        ),
                        )
              ),
            ],
          ),
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.google),
            iconSize: 50.0,
            onPressed: () {
              // Acción al presionar el botón
            },
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: _buildBody(context),
      ),
    );
  }
}
