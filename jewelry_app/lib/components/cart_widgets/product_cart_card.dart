import 'package:flutter/material.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:provider/provider.dart';

class ProductCartCard extends StatelessWidget {
  final Producto producto;
  final int cantidad;

  const ProductCartCard({
    Key? key,
    required this.producto,
    required this.cantidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2), // Cambia la dirección de la sombra.
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del producto
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              producto.imagenUrl,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(width: 10),
          // Detalles del producto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Nombre del producto
                    Expanded(
                      child: Text(
                        producto.nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Botón de eliminación
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => shoppingCartProvider.removeProductFromCart(producto),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  producto.descripcion,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Botón para disminuir la cantidad
                    _buildQuantityButton(context, shoppingCartProvider, Icons.remove, () {
                      shoppingCartProvider.decreaseProductQuantity(producto);
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "$cantidad",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Botón para aumentar la cantidad
                    _buildQuantityButton(context, shoppingCartProvider, Icons.add, () {
                      shoppingCartProvider.addProductToCart(producto, 1);
                    }),
                    const Spacer(),
                    // Precio del producto
                    Text(
                      "\$${producto.precio.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Botón para aumentar o disminuir la cantidad
  Widget _buildQuantityButton(
      BuildContext context, ShoppingCartProvider shoppingCartProvider, IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}

