import 'package:flutter/material.dart';
import 'package:jewelry_app/pages/sign_in/sign_in_page.dart';
import 'package:jewelry_app/pages/sign_up/sign_up_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      initialRoute: '/sign-in',
      routes: {
        '/sign-in': (context) => const SignInPage(),
        '/sign-up': (context) => const SignUpPage(),
      },
    );
  }
}
