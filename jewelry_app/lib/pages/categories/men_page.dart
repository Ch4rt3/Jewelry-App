import 'package:flutter/material.dart';
import 'package:jewelry_app/components/categories_widgets/category_page.dart';
class MenPage extends StatelessWidget {
  const MenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CategoryPage(categoryName: 'Men');
  }
}
