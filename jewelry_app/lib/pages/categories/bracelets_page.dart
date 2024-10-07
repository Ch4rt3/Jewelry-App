import 'package:flutter/material.dart';
import 'package:jewelry_app/components/categories_widgets/category_page.dart';
import 'package:jewelry_app/models/producto.dart';

class BraceletsPage extends StatelessWidget {
  final List<Producto> allProducts;

  BraceletsPage({Key? key, required this.allProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryPage(
      categoryName: "Bracelets", 
      allProducts: allProducts,
    );
  }
}