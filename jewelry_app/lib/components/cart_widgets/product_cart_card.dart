import 'package:flutter/material.dart';
import 'package:jewelry_app/models/producto.dart';

class ProductCartCard extends StatelessWidget {
  final Producto producto;
  final int cantidad;

  const ProductCartCard({Key? key, required this.producto, required this.cantidad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              producto.imagenUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${producto.precio.toString()}",
                    style: const TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  Text(
                    "Cantidad: $cantidad",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Lógica para eliminar el producto del carrito
              },
            ),
          ],
        ),
      ),
    );
  }
}
