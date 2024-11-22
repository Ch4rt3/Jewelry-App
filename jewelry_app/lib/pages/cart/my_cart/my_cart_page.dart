import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/providers/product_provider.dart';  // Importamos el ProductProvider
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:jewelry_app/components/cart_widgets/product_cart_card.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
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

    // Aquí se llamará al provider para obtener el carrito de productos
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    await productProvider.fetchAllProducts(); // Cargar todos los productos (o productos por categoría si es necesario)

    setState(() {
      // En este caso suponemos que los productos ya están cargados
      _subTotal = productProvider.productos.fold(0, (total, producto) => total + producto.precio);
    });
  }

  Future<void> _actualizarCantidad(int carritoId, int productoId, int nuevaCantidad) async {
    // Implementa el cambio de cantidad en el carrito según la cantidad
    setState(() {
      // Aquí iría la lógica para actualizar el subtotal después de modificar la cantidad
      _subTotal += nuevaCantidad * 10.0; // Ejemplo de actualización
    });
  }

  Future<void> _eliminarProducto(int carritoId, int productoId) async {
    // Implementa la eliminación de un producto en el carrito
    setState(() {
      // Aquí iría la lógica para eliminar el producto y actualizar el subtotal
      _subTotal -= 10.0; // Ejemplo de eliminación
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final carritoId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: productProvider.productos.map((producto) {
                      return ProductCartCard(
  producto: producto,
  cantidad: 1, // Asignar la cantidad real aquí
  onDecrease: () {
    // Convertir carritoId a int si es necesario
    final carritoIdInt = int.tryParse(carritoId!); // Usar tryParse para evitar errores si la conversión falla
    if (carritoIdInt != null) {
      _actualizarCantidad(carritoIdInt, producto.id, 1 - 1);
    } else {
      print("Error: carritoId no es un número válido.");
    }
  },
  onIncrease: () {
    final carritoIdInt = int.tryParse(carritoId!);
    if (carritoIdInt != null) {
      _actualizarCantidad(carritoIdInt, producto.id, 1 + 1);
    } else {
      print("Error: carritoId no es un número válido.");
    }
  },
  onRemove: () {
    final carritoIdInt = int.tryParse(carritoId!);
    if (carritoIdInt != null) {
      _eliminarProducto(carritoIdInt, producto.id);
    } else {
      print("Error: carritoId no es un número válido.");
    }
  },
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
  // Acceder a la instancia de ProductProvider usando Provider.of
  final productProvider = Provider.of<ProductProvider>(context, listen: false);

  if (productProvider.productos.isNotEmpty) {
    Navigator.pushNamed(context, '/checkout');
  } else {
    // Manejar el caso cuando no hay productos
    // Puedes mostrar un mensaje o hacer algo similar
  }
}
,
        child: const Text(
          'Go to Checkout',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
