import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';
import 'package:jewelry_app/models/producto.dart';
import 'package:jewelry_app/components/categories_widgets/productCard.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;
  final List<Producto> allProducts;

  CategoryPage({
    Key? key,
    required this.categoryName,
    required this.allProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Producto> categoryProducts = allProducts.where((product) => product.categoria == categoryName).toList();

    return MainBackground(
      showDiamondMessage: false,  
      message: categoryName,    
      showComplementMessage: false, 
      subtitle: categoryName,
      body: SizedBox(
        height: 400,  
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Desplazamiento horizontal de la lista de productos
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: categoryProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(right: 10.0),  // Margen entre cada tarjeta
              child: ProductCard(product: categoryProducts[index]),
            );
          },
        ),
      ),
    );
  }
}


