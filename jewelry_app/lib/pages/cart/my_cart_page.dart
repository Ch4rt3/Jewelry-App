import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:jewelry_app/components/cart_widgets/product_cart_card.dart';

class MyCartPage extends StatelessWidget {

  const MyCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
          ),
          const SizedBox(height: 20),
          _buildPaymentSummary(shoppingCartProvider),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/checkout');
            },
            child: const Center(child: Text('Go to Checkout')),
          ),
        ],
      ),
    );
  }

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

