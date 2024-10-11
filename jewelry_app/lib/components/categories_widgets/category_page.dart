import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/components/categories_widgets/productCard.dart';
import 'package:jewelry_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    // Utilizar el ProductProvider para obtener los productos de la categoría
    final productProvider = Provider.of<ProductProvider>(context);
    List<Producto> categoryProducts = productProvider.productos
        .where((product) => product.categoria == categoryName)
        .toList();

    return MainBackground(
      showDiamondMessage: false,  
      message: categoryName,    
      showComplementMessage: false, 
      subtitle: categoryName,
      body: SingleChildScrollView(  // Permitir scroll si es necesario
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categoryProducts.map((product) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),  // Márgenes laterales
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),  // Margen inferior entre tarjetas
                width: double.infinity,  // Expandir la tarjeta horizontalmente
                child: ProductCard(producto: product),  // Mostrar cada producto
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}



