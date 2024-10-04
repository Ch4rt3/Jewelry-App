import 'package:flutter/material.dart';

class DetalleOrdenPage extends StatelessWidget {
  final dynamic order;

  const DetalleOrdenPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order No: ${order['orderNo']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order No: ${order['orderNo']}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Date: ${order['date']}", style: const TextStyle(fontSize: 16)),
            Text("Total Amount: \$${order['totalAmount']}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text("Products:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildProductsList(order['products']),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsList(List<dynamic> products) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product['name']),
            subtitle: Text("Price: \$${product['price']}"),
          );
        },
      ),
    );
  }
}