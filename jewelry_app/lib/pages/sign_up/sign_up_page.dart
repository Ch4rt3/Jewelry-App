import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jewelry_app/components/auth_background.dart';
import 'package:jewelry_app/components/large_button.dart';
import 'package:jewelry_app/components/large_text_form_field.dart';
import 'package:jewelry_app/components/sign_in_with_account.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  Widget _buildBody(BuildContext context) {
    return AuthBackground(
      titulo: "Registrarse",
      children: [
        LargeTextFormField(
          titulo: "Correo electrónico",
          onPressed: () => {},
        ),
        const SizedBox(height: 20),
        LargeTextFormField(
          titulo: "Contraseña",
          onPressed: () => {},
        ),
        const SizedBox(height: 20),
        LargeTextFormField(
          titulo: "Confirmar contraseña",
          onPressed: () => {},
        ),
        const SizedBox(height: 10),
        LargeButton(
          titulo: "REGISTRARSE",
          onPressed: () {
            // Aquí puedes agregar la navegación al finalizar el registro
            // Navigator.pushNamed(context, "/home"); // Por ejemplo, a la página principal
          },
        ),
        const SizedBox(height: 5),
        const SignInWithAccount(), // Este widget es correcto
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.google),
          iconSize: 50.0,
          onPressed: () {
            // Acción al presionar el botón
          },
        ),
      ],
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
