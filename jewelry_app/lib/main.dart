import 'package:flutter/material.dart';
import 'package:jewelry_app/pages/auth/reset/forgot_password_page.dart';
import 'package:jewelry_app/pages/auth/reset/recovery_password_page.dart';
import 'package:jewelry_app/pages/auth/sign_in/sign_in_page.dart';
import 'package:jewelry_app/pages/auth/sign_up/sign_up_page.dart';
import 'package:jewelry_app/pages/auth/success/success_password_page.dart';
import 'package:jewelry_app/pages/main/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jewelry App',
      theme: ThemeData(
        fontFamily: 'Lexend',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      initialRoute: '/sign-in',
      routes: {
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgetPasswordPage(),
        '/recovery-password': (context) => const RecoveryPasswordPage(),
        '/success-password': (context) => const SuccessPasswordPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
