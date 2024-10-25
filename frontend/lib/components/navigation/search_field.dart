import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChange;

  const SearchField({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: onChange,
    );
  }
}
