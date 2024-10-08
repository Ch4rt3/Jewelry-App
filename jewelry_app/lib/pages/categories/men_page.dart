import 'package:flutter/material.dart';
import 'package:jewelry_app/components/categories_widgets/category_page.dart';
import 'package:jewelry_app/models/producto.dart';

class MenPage extends StatelessWidget {
  final List<Producto> allProducts;

  MenPage({super.key, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      categoryName: "Men", 
      allProducts: allProducts,
    );
  }
}
