import 'package:flutter/material.dart';
import 'package:jewelry_app/pages/cart/my_cart/my_cart_controller.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:jewelry_app/components/cart_widgets/product_cart_card.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:jewelry_app/components/cart_widgets/product_cart_card.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context);
    final user = Provider.of<UserProvider>(context);
    print(user.usuario?.carritoId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Verificar si la lista de productos no está vacía
            shoppingCartProvider.productosEnCarrito.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: shoppingCartProvider.productosEnCarrito.length,
                      itemBuilder: (context, index) {
                        final producto = shoppingCartProvider.productosEnCarrito[index];
                        final cantidad = shoppingCartProvider.cantidadProducto(producto);
                        return ProductCartCard(
                          producto: producto,
                          cantidad: cantidad,
                        );
                      },
                    ),
                  )
                : const Expanded(
                    child: Center(
                      child: Text(
                        "No hay productos en el carrito.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            _buildPaymentSummary(shoppingCartProvider),
            const SizedBox(height: 10),
        
            // Botón de "Go to Checkout" con ajustes de tamaño y diseño
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity, // Usar toda la anchura disponible
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Redondear bordes del botón
                  ),
                ),
                onPressed: () {
                  // Solo permitir ir a checkout si hay productos en el carrito
                  // if (shoppingCartProvider.productosEnCarrito.isNotEmpty) {
                    Navigator.pushNamed(context, '/checkout');
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(content: Text("No hay productos en el carrito para proceder al checkout.")),
                  //   );
                  // }
                },
                child: const Text(
                    'Go to Checkout', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                      )
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Definición del método buildPaymentSummary corregido
  Widget _buildPaymentSummary(ShoppingCartProvider shoppingCartProvider) {
    final itemTotal = shoppingCartProvider.subTotal;
    const deliveryFee = 50.0;
    final total = itemTotal + deliveryFee;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Item total', '\$${itemTotal.toStringAsFixed(2)}'),
          _buildSummaryRow('Delivery fee', '\$${deliveryFee.toStringAsFixed(2)}'),
          const Divider(),
          _buildSummaryRow('Total', '\$${total.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}



