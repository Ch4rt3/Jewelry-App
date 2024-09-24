
import 'package:flutter/material.dart';
import 'package:jewelry_app/configs/colors.dart';

class SignInWithAccount extends StatelessWidget {
  const SignInWithAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        );
  }
}