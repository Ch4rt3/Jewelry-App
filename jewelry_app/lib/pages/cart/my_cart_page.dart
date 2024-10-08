import 'package:flutter/material.dart';
import 'package:jewelry_app/models/carrito.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/components/cart_widgets/product_cart_card.dart'; 

class MyCartPage extends StatelessWidget {
  final Carrito carrito;

  MyCartPage({super.key, required this.carrito});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: carrito.productos.length,
                itemBuilder: (context, index) {
                  final Producto producto = carrito.productos[index];
                  return ProductCartCard(
                    producto: producto,
                    cantidad: 1,  // Asumiendo cantidad fija. Se puede extender a una propiedad del modelo.
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildCartSummary(),  // Mostrar el total del carrito
            const SizedBox(height: 20),
            _buildCheckoutButton(context),  // Botón para ir a la pantalla de checkout
          ],
        ),
      ),
    );
  }

  // Widget para mostrar el resumen del carrito
  Widget _buildCartSummary() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow("Item Total", "\$${carrito.subTotal.toStringAsFixed(2)}"),
          const SizedBox(height: 10),
          _buildSummaryRow("Delivery Fee", "\$10"),  // Puedes agregar un cálculo dinámico si es necesario
          const Divider(),
          _buildSummaryRow("Total", "\$${(carrito.subTotal + 10).toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  // Método para mostrar cada fila del resumen
  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // Botón para ir a la pantalla de checkout
  Widget _buildCheckoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/checkout', arguments: carrito);
        },
        child: const Text("Go to Checkout"),
      ),
    );
  }
}
