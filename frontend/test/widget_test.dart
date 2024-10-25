// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/main.dart'; // Ajusta esta ruta según la ubicación de tu `main.dart`
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:jewelry_app/providers/order_provider.dart';
import 'package:jewelry_app/providers/product_provider.dart';
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/models/carrito.dart';

void main() {
  // Configurar el test
  testWidgets('Prueba de integración básica para la app de joyería', (WidgetTester tester) async {
    // Crear usuario y carrito de prueba
    final usuarioPrueba = Usuario(
      id: 1,
      nombre: 'testUser',
      email: 'test@example.com',
      url: 'http://example.com',
      descripcion: 'test description',
      acercaDe: 'about testUser',
      imagen: 'http://example.com/image.png',
      telefono: '1234567890',
      visibilidad: true,
      contrasena: 'testPassword',
    );

    final carritoPrueba = Carrito(
      id: 1,
      usuarioId: usuarioPrueba.id,
      productosEnCarrito: [],
      subTotal: 0.0,
    );

    // Envolver el widget principal con los providers requeridos para las pruebas
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider()..setUser(usuarioPrueba),
          ),
          ChangeNotifierProvider<ShoppingCartProvider>(
            create: (_) => ShoppingCartProvider()..initializeCart(carritoPrueba),
          ),
          ChangeNotifierProvider<OrderProvider>(
            create: (_) => OrderProvider(),
          ),
          ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider(),
          ),
        ],
        child: const MyApp(), // Tu widget principal
      ),
    );

    // Esperar a que la app se cargue
    await tester.pumpAndSettle();

    // Realizar algunas verificaciones básicas para asegurar que la app carga correctamente
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Men'), findsWidgets); // Cambiar según el texto que aparezca en la UI de inicio

    // Verificar que no hay errores al cargar la app
    expect(find.text('Error'), findsNothing);
  });
}

