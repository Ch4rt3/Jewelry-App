import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/providers/product_provider.dart'; 
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double _itemTotal = 0.0;
  static const double _deliveryFee = 50.0;
  String _direccion = 'Cargando dirección...';
  String _metodoPago = 'Cargando método de pago...';

  @override
  void initState() {
    super.initState();
    _cargarProductos();
    _cargarDireccion();
    _cargarMetodoPago();
  }

  Future<void> _cargarProductos() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final usuarioId = userProvider.userId;

    if (usuarioId == null) {
      print("Error: No hay usuario autenticado");
      return;
    }

    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    await productProvider.fetchAllProducts(); // Obtener los productos desde el provider

    setState(() {
      _itemTotal = 0.0;
      for (var producto in productProvider.productos) {
        // Calcular el total sumando el precio de cada producto
        _itemTotal += producto.precio; // Asumimos que 'precio' es el atributo adecuado del modelo Producto
      }
    });
  }

  Future<void> _cargarDireccion() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final usuarioId = userProvider.userId;

    try {
      final response = await http.get(Uri.parse('http://192.168.19.60:4568/direcciones/usuario/$usuarioId'));
      if (response.statusCode == 200) {
        final direcciones = jsonDecode(response.body);
        setState(() {
          _direccion = direcciones[0]['Direccion'] ?? 'Dirección no disponible';
        });
      } else {
        print('Error al cargar la dirección');
      }
    } catch (e) {
      print('Error en _cargarDireccion: $e');
    }
  }

  Future<void> _cargarMetodoPago() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final usuarioId = userProvider.userId;

    try {
      final response = await http.get(Uri.parse('http://192.168.19.60:4568/wallets/usuario/$usuarioId'));
      if (response.statusCode == 200) {
        final metodosPago = jsonDecode(response.body);
        setState(() {
          _metodoPago = '**** **** **** ${metodosPago[0]['numeroTarjeta'].toString().substring(12)}';
        });
      } else {
        print('Error al cargar el método de pago');
      }
    } catch (e) {
      print('Error en _cargarMetodoPago: $e');
    }
  }

  Future<void> _confirmarPedido() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final usuarioId = userProvider.userId;

    if (usuarioId == null) {
      print("Error: No hay usuario autenticado");
      return;
    }

    try {
      final response = await http.post(Uri.parse('http://192.168.19.60:4568/carrito/$usuarioId/confirmar'));
      if (response.statusCode == 201) {
        print('Pedido confirmado exitosamente');
        Navigator.pushNamed(context, "/success-order");
      } else {
        print('Error al confirmar el pedido: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en _confirmarPedido: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            _buildAddressSection(),
            const SizedBox(height: 20),
            _buildPaymentMethodSection(),
            const SizedBox(height: 20),
            _buildOrderSummary(),
            const SizedBox(height: 20),
            _buildPlaceOrderButton(),
          ],
        ),
      ),
    );
  }

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
              _direccion,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/address");
            },
            child: const Text(
              'Change Address',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

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
              _metodoPago,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[100],
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/wallet");
            },
            child: const Text(
              'Use Other',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final total = _itemTotal + _deliveryFee;
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
          _buildSummaryRow('Item Total', '\$${_itemTotal.toStringAsFixed(2)}'),
          _buildSummaryRow('Delivery Fee', '\$${_deliveryFee.toStringAsFixed(2)}'),
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

  Widget _buildPlaceOrderButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: _confirmarPedido,
        child: const Text(
          'Place Order',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


