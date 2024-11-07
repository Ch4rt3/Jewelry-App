import 'package:flutter/material.dart';
import 'package:jewelry_app/pages/auth/reset/forgot_password/forgot_password_page.dart';
import 'package:jewelry_app/pages/auth/reset/recovery_password/recovery_password_page.dart';
import 'package:jewelry_app/pages/auth/sign_in/sign_in_page.dart';
import 'package:jewelry_app/pages/auth/sign_up/sign_up_page.dart';
import 'package:jewelry_app/pages/auth/success/success_password_page.dart';
import 'package:jewelry_app/pages/cart/success/success_order_page.dart';
import 'package:jewelry_app/pages/main/about_us/about_us_page.dart';
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
import 'package:jewelry_app/pages/cart/my_cart/my_cart_page.dart';  
import 'package:jewelry_app/pages/cart/checkout/checkout_page.dart';
import 'package:jewelry_app/providers/product_provider.dart';
import 'package:jewelry_app/providers/user_provider.dart'; 
import 'package:jewelry_app/providers/order_provider.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/direccion_provider.dart'; 
import 'providers/pais_provider.dart';
import 'providers/ciudad_provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => ShoppingCartProvider()),
        ChangeNotifierProvider(create: (context) => DireccionProvider()), // Agrega DireccionProvider aquí
        ChangeNotifierProvider(create: (context) => PaisProvider()),
        ChangeNotifierProvider(create: (context) => CiudadProvider()),
      ],
      child: MaterialApp(
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
          '/about-us': (context) => const AboutUsPage(),
          '/user': (context) => const UserPage(),
          '/wallet': (context) => const WalletPage(),
          '/create-wallet': (context) => const CreateWalletPage(),
          '/settings': (context) => const SettingsPage(),
          '/orders': (context) => const OrdersPage(),
          '/address': (context) => const AddressPage(),
          '/men': (context) => const MenPage(),
          '/rings': (context) => const  RingsPage(),
          '/earrings': (context) => const EarringsPage(),
          '/bracelets': (context) => const BraceletsPage(),
          '/necklaces': (context) => const NecklacesPage(),
          '/cart': (context) => const MyCartPage(),  
          '/checkout': (context) => const CheckoutPage(),  
          '/success-order': (context) => const SuccessOrderPage(),  
        },
      ),
    );
  }
}
