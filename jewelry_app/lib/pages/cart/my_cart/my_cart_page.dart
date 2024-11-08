import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/components/cart_widgets/product_cart_card.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<Producto> _carritoProductos = [];
  double _subTotal = 0.0;
  static const double _deliveryFee = 50.0;

  @override
  void initState() {
    super.initState();
    _cargarCarrito();
  }

  Future<void> _cargarCarrito() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final usuarioId = userProvider.userId;

    if (usuarioId == null) {
      print("Error: No hay usuario autenticado");
      return;
    }

    try {
      final response = await http.get(Uri.parse('http://192.168.19.60:4568/carrito/$usuarioId'));
      if (response.statusCode == 200) {
        final carritoData = jsonDecode(response.body);
        setState(() {
          _carritoProductos = (carritoData['productos'] as List)
              .map((json) => Producto.fromJson(json))
              .toList();
          _subTotal = carritoData['SubTotal'];
        });
      } else {
        print('Error al cargar el carrito');
      }
    } catch (e) {
      print('Error en _cargarCarrito: $e');
    }
  }

  Future<void> _actualizarSubtotal(int carritoId) async {
    try {
      final response = await http.put(Uri.parse('http://192.168.19.60:4568/carrito/$carritoId/actualizar_subtotal'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _subTotal = data['nuevo_subtotal'];
        });
      } else {
        print('Error al actualizar el subtotal');
      }
    } catch (e) {
      print('Error en _actualizarSubtotal: $e');
    }
  }

  Future<void> _actualizarCantidad(int carritoId, int productoId, int nuevaCantidad) async {
    try {
      await http.put(
        Uri.parse('http://192.168.19.60:4568/carrito/$carritoId/producto/$productoId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'cantidad': nuevaCantidad}),
      );
      _actualizarSubtotal(carritoId);
      _cargarCarrito();
    } catch (e) {
      print('Error en _actualizarCantidad: $e');
    }
  }

  Future<void> _eliminarProducto(int carritoId, int productoId) async {
    try {
      await http.delete(Uri.parse('http://192.168.19.60:4568/carrito/$carritoId/producto/$productoId'));
      _actualizarSubtotal(carritoId);
      _cargarCarrito();
    } catch (e) {
      print('Error en _eliminarProducto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final carritoId = userProvider.userId;

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
            Column(
              children: _carritoProductos.map((producto) {
                return ProductCartCard(
                  producto: producto,
                  cantidad: 1, // Asignar la cantidad real aquí
                  onDecrease: () {
                    if (1 > 1) {
                      _actualizarCantidad(carritoId! as int, producto.id, 1 - 1);
                    } else {
                      _eliminarProducto(carritoId! as int, producto.id);
                    }
                  },
                  onIncrease: () => _actualizarCantidad(carritoId! as int, producto.id, 1 + 1),
                  onRemove: () => _eliminarProducto(carritoId! as int, producto.id),
                );
              }).toList(),
            ),
            _buildPaymentSummary(),
            const SizedBox(height: 20),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    final total = _subTotal + _deliveryFee;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Item total', '\$${_subTotal.toStringAsFixed(2)}'),
          _buildSummaryRow('Delivery fee', '\$${_deliveryFee.toStringAsFixed(2)}'),
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

  Widget _buildCheckoutButton() {
    return Container(
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
          if (_carritoProductos.isNotEmpty) {
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
    );
  }
}
