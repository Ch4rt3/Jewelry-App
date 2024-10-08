import 'package:flutter/material.dart';
import 'package:jewelry_app/models/carrito.dart';

class CheckoutPage extends StatelessWidget {
  final Carrito carrito;

  const CheckoutPage({Key? key, required this.carrito}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddressSection(),  // Sección de dirección de entrega
            const SizedBox(height: 20),
            _buildPaymentSection(),  // Sección de método de pago
            const SizedBox(height: 20),
            _buildSummarySection(),  // Resumen del monto total
            const Spacer(),
            _buildPlaceOrderButton(context),  // Botón para confirmar la compra
          ],
        ),
      ),
    );
  }

  // Sección de dirección de entrega
  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deliver to", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("123 Main Street, Springfield, USA"),  // Dirección predeterminada
          SizedBox(height: 10),
          TextButton(onPressed: null, child: Text("Change Address")),
        ],
      ),
    );
  }

  // Sección de método de pago
  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("**** **** **** 1234 (Visa)"),  // Método de pago predeterminado
          SizedBox(height: 10),
          TextButton(onPressed: null, child: Text("Use Other")),
        ],
      ),
    );
  }

  // Resumen del monto total
  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("\$${(carrito.subTotal + 10).toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Botón para confirmar la compra
  Widget _buildPlaceOrderButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: () {
          // Lógica para confirmar la compra
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order Placed Successfully")));
        },
        child: const Text("Place Order"),
      ),
    );
  }
}
