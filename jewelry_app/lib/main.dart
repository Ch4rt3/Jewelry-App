import 'package:flutter/material.dart';
import 'package:jewelry_app/pages/auth/reset/forgot_password/forgot_password_page.dart';
import 'package:jewelry_app/pages/auth/reset/recovery_password/recovery_password_page.dart';
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
import 'package:jewelry_app/pages/cart/my_cart_page.dart';  
import 'package:jewelry_app/pages/cart/checkout_page.dart';
import 'package:jewelry_app/providers/product_provider.dart';
import 'package:jewelry_app/providers/user_provider.dart'; 
import 'package:jewelry_app/services/product_service.dart';
import 'package:jewelry_app/services/user_service.dart';
import 'package:jewelry_app/services/shoppingcart_service.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/models/carrito.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ProductoService productoService = ProductoService();
  UsuarioService usuarioService = UsuarioService();
  CarritoService carritoService = CarritoService();
  List<Producto> productos = await productoService.fetchAll();
  Usuario? usuario = await usuarioService.getUsuarioById(1);  // Asumiendo que cargamos el usuario con ID = 1
  Carrito? carrito = await carritoService.getCarritoByUsuarioId(1);  // Cargar el carrito del usuario con ID = 1

  runApp(MyApp(
    productos: productos,
    usuario: usuario,
    carrito: carrito,
  ));
}

class MyApp extends StatelessWidget {
  final List<Producto> productos;
  final Usuario? usuario;
  final Carrito? carrito;

  const MyApp({
    super.key,
    required this.productos,
    required this.usuario,
    required this.carrito,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserProvider()
          ),
        ChangeNotifierProvider(
            create: (context) => ProductProvider()
          ),
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
          '/cart': (context) => MyCartPage(carrito: carrito!),  
          '/checkout': (context) => CheckoutPage(carrito: carrito!),  
        },
      ),
    );
  }
}

