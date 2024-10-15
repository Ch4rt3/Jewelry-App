import 'package:flutter/material.dart';
import 'package:jewelry_app/components/notifications/sucess_notification.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/shoppingcart_provider.dart';
import 'package:jewelry_app/providers/order_provider.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/pages/cart/my_cart/my_cart_controller.dart';

class CheckoutPage extends StatefulWidget {
    const CheckoutPage({super.key});
    @override
    _CheckoutPageState createState() => _CheckoutPageState();
  }

class _CheckoutPageState extends State<CheckoutPage> {
    double itemTotal = 0.0;
    static const deliveryFee = 50.0;
    List<Producto> carritoProducto = [];
    
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
    // Obtener los providers de ShoppingCart y Order
    final shoppingCartProvider = Provider.of<ShoppingCartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de la Orden',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Sección de Dirección de Entrega Estática
            _buildAddressSection(),

            const SizedBox(height: 20),

            // Sección de Método de Pago Estática
            _buildPaymentMethodSection(),

            const SizedBox(height: 20),

            // Resumen de productos en el carrito
            _buildOrderSummary(shoppingCartProvider),

            const SizedBox(height: 20),

            // Botón para colocar la orden
            _buildPlaceOrderButton(context, shoppingCartProvider, orderProvider),
          ],
        ),
      ),
    );
  }

  // Sección de dirección de entrega estática
  Widget _buildAddressSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '123 Calle Principal, Ciudad de Ejemplo',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
              elevation: 0,
            ),
            onPressed: () {},
            child: const Text(
              'Change Address',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  // Sección de método de pago estática
  Widget _buildPaymentMethodSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '**** **** **** 1234',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
              elevation: 0,
            ),
            onPressed: () {},
            child: const Text(
              'Use Other',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  // Mostrar el resumen del pedido con el subtotal y el costo de envío
  Widget _buildOrderSummary(ShoppingCartProvider shoppingCartProvider) {
    final total = itemTotal + deliveryFee;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Item Total', '\$${itemTotal.toStringAsFixed(2)}'),
          _buildSummaryRow('Delivery Fee', '\$${deliveryFee.toStringAsFixed(2)}'),
          const Divider(),
          _buildSummaryRow('Total', '\$${total.toStringAsFixed(2)}', isTotal: true),
        ],
      ),
    );
  }

  // Widget para construir las filas del resumen de la orden
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

  // Botón para realizar el pedido
  Widget _buildPlaceOrderButton(BuildContext context, ShoppingCartProvider shoppingCartProvider, OrderProvider orderProvider) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.all(16.0),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          // if (shoppingCartProvider.productosEnCarrito.isNotEmpty) {
            // await shoppingCartProvider.placeOrder(context);
            Navigator.pushNamed(context, "/success-order");
            // shoppingCartProvider.clearCart();
            // Navigator.popUntil(context, ModalRoute.withName('/'));
          // } else {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text("Your cart is empty!")),
            // );
          // }
        },
        child: const Text(
            "Place Order",
            style: TextStyle(
              color: Colors.white
            ),
          ),
      ),
    );
  }
}



