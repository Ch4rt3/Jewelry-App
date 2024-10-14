import 'package:flutter/material.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/pages/cart/my_cart/my_cart_controller.dart';
import 'package:jewelry_app/components/cart_widgets/product_cart_card.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<Producto> carritoProducto = [];
  double itemTotal = 0.0; // Variable para el total de los artículos
  static const double deliveryFee = 50.0; // Tarifa de entrega

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    MyCartController myCartController = MyCartController();
    List<Producto> productos = await myCartController.cargarCarritoProductos(context);
    setState(() {
      carritoProducto = productos;
      itemTotal = _calculateItemTotal(productos); // Calcula el total de los artículos
    });
  }

  double _calculateItemTotal(List<Producto> productos) {
    // Sumar el precio de cada producto en el carrito
    double total = 0.0;
    for (var producto in productos) {
      total += producto.precio; // Asegúrate de que 'precio' sea la propiedad correcta
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Lista de productos en el carrito
            Column(
              children: carritoProducto.map((producto) {
                int cantidad = 1; // Cantidad por defecto
                return ProductCartCard(
                  producto: producto,
                  cantidad: cantidad,
                  onDecrease: () {
                    // Lógica para disminuir la cantidad
                  },
                  onIncrease: () {
                    // Lógica para aumentar la cantidad
                  },
                  onRemove: () {
                    // Lógica para eliminar el producto
                  },
                );
              }).toList(),
            ),
            // Resumen de pago
            _buildPaymentSummary(),
            SizedBox(height: 20),
            // Botón de checkout
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (carritoProducto.isNotEmpty) { // Verifica si hay productos en el carrito
                    Navigator.pushNamed(context, '/checkout');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No hay productos en el carrito para proceder al checkout.")),
                    );
                  }
                },
                child: const Text(
                  'Go to Checkout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
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
