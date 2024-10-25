
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jewelry_app/configs/colors.dart';

class SignInWithAccount extends StatelessWidget {
  const SignInWithAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-in");
                  }, 
                  child: const Text(
                          "Sign in with account",
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
          ],
    );
  }
}