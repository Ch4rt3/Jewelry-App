import 'package:flutter/material.dart';
import 'package:jewelry_app/components/buttons/custom_elevated_buttom.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';
import 'package:jewelry_app/configs/colors.dart';
import 'package:jewelry_app/models/producto.dart';

class ProductPage extends StatefulWidget {
  final Producto producto;
  const ProductPage({super.key, required this.producto});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int cantidad = 1; // Variable para llevar la cuenta de la cantidad

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      searchBar: false,
      automaticallyImplyLeading: true,
      showComplementMessage: false,
      showDiamondMessage: false,
      message: "",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 290,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(widget.producto.imagenUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.producto.nombre,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${widget.producto.precio}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondTextColor,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (cantidad > 1) cantidad--;
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  cantidad.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (cantidad < widget.producto.stock) cantidad++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
                Text(
                  "Only ${widget.producto.stock} in stock",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.producto.descripcionLarga,
                style: const TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevatedButton(
                  textColor: AppColors.textColor,
                  onPressed: () {
                    _agregarAlCarrito();
                  },
                  message: "Add to Cart",
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/cart");
                  },
                  message: "Buy Now",
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.thirdColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Bottom navigation bar space if necessary
          ],
        ),
      ),
    );
  }
  void _agregarAlCarrito() {
    // Lógica para agregar el producto al carrito (puedes agregar la lógica aquí)

    // Mostrar el SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¡Producto agregado exitosamente!'),
        duration: const Duration(seconds: 2), // Duración del SnackBar
        backgroundColor: Colors.green, // Color de fondo del SnackBar
      ),
    );
  }
}
