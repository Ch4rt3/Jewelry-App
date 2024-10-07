import 'package:flutter/material.dart';
import 'package:jewelry_app/components/categories_widgets/category_page.dart';
import 'package:jewelry_app/models/producto.dart';

class NecklacesPage extends StatelessWidget {
  final List<Producto> allProducts;

  NecklacesPage({Key? key, required this.allProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      categoryName: "Necklaces", 
      allProducts: allProducts,
    );
  }
}