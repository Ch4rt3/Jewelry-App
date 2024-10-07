import 'package:flutter/material.dart';
import 'package:jewelry_app/pages/auth/reset/forgot_password_page.dart';
import 'package:jewelry_app/pages/auth/reset/recovery_password_page.dart';
import 'package:jewelry_app/pages/auth/sign_in/sign_in_page.dart';
import 'package:jewelry_app/pages/auth/sign_up/sign_up_page.dart';
import 'package:jewelry_app/pages/auth/success/success_password_page.dart';
import 'package:jewelry_app/pages/main/home/home_page.dart';
import 'package:jewelry_app/pages/user/user_page.dart';
import 'package:jewelry_app/pages/user/wallet/wallet_page.dart';
import 'package:jewelry_app/pages/user/wallet/create_wallet_page.dart';
import 'package:jewelry_app/pages/user/settings/settings_page.dart';
import 'package:jewelry_app/pages/user/orders/orders_page.dart';
import 'package:jewelry_app/pages/user/address/address_page.dart';
import 'package:jewelry_app/pages/categories/men_page.dart';
import 'package:jewelry_app/pages/categories/rings_page.dart';
import 'package:jewelry_app/pages/categories/earrings_page.dart';
import 'package:jewelry_app/pages/categories/bracelets_page.dart';
import 'package:jewelry_app/pages/categories/necklaces_page.dart';
import 'package:jewelry_app/services/product_service.dart';
import 'package:jewelry_app/models/producto.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ProductoService productoService = ProductoService();
  List<Producto> productos = await productoService.fetchAll();
  runApp(MyApp(productos: productos));
}

class MyApp extends StatelessWidget {
  final List<Producto> productos;

  const MyApp({Key? key, required this.productos}) : super(key: key);

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
        '/user': (context) => const UserPage(),
        '/wallet': (context) => const WalletPage(),
        '/create-wallet': (context) => const CreateWalletPage(),
        '/settings': (context) => const SettingsPage(),
        '/orders': (context) => const OrdersPage(),
        '/address': (context) => const AddressPage(),
        '/men': (context) => MenPage(allProducts: productos),
        '/rings': (context) => RingsPage(allProducts: productos),
        '/earrings': (context) => EarringsPage(allProducts: productos),
        '/bracelets': (context) => BraceletsPage(allProducts: productos),
        '/necklaces': (context) => NecklacesPage(allProducts: productos),
      },
    );
  }
}

