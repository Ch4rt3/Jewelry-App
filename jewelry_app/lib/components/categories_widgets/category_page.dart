import 'package:flutter/material.dart';
import 'package:jewelry_app/components/layouts/main_background.dart';
import 'package:jewelry_app/components/categories_widgets/productCard.dart';
import 'package:jewelry_app/providers/product_provider.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return FutureBuilder(
      future: productProvider.fetchProductsByCategory(categoryName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return MainBackground(
            searchBar: true,
            showDiamondMessage: false,
            message: "",
            showComplementMessage: false,
            subtitle: categoryName,
            automaticallyImplyLeading: false,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: productProvider.productos.map((product) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      width: double.infinity,
                      child: ProductCard(producto: product),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }
}




