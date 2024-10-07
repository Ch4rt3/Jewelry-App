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
      body: SizedBox(
        height: 400,  
        child: ListView.builder(
          scrollDirection: Axis.horizontal, 
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          itemCount: categoryProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SizedBox(
                width: 200,  
                child: ProductCard(product: categoryProducts[index]),  
              ),
            );
          },
        ),
      ),
    );
  }
}
