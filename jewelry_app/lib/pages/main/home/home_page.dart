import 'package:flutter/material.dart';
import 'package:jewelry_app/components/categories_widgets/productCard.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';
import 'package:jewelry_app/pages/main/home/home_page_controller.dart';
import 'package:jewelry_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:jewelry_app/providers/product_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController controller = HomePageController(context);
    final userProvider = Provider.of<UserProvider>(context);

    // Cargar productos al iniciar
    Future.microtask(() => controller.loadProducts());

    return MainBackground(
      message: "Hello, User",
      showDiamondMessage: true,
      showComplementMessage: true,
      body: const ProductList(),
    );
  }
}

// Widget para listar los productos
class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (productProvider.productos.isEmpty) {
      return const Center(child: Text('No se encontraron productos'));
    }

    return SingleChildScrollView(
      child: Column(
        children: productProvider.productos.map((producto) {
          return ProductCard(producto: producto);
        }).toList(),
      ),
    );
  }
}
