import 'package:flutter/material.dart';
import 'package:jewelry_app/components/filter/filter_modal.dart';

class FilterModalButton extends StatefulWidget {
  const FilterModalButton({super.key});

  @override
  _FilterModalButtonState createState() => _FilterModalButtonState();
}

class _FilterModalButtonState extends State<FilterModalButton> {
  RangeValues _priceRange = const RangeValues(20, 80);
  String _selectedSortOption = 'Newest'; // Opción inicial
  final List<String> _sortOptions = [
    'Newest',
    'Price: Low to High',
    'Price: High to Low',
    'Name A-Z',
    'Name Z-A',
  ];

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: const BorderSide(
          color: Colors.black87,
          width: 1,
        ),
        padding: const EdgeInsets.all(8),
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return FilterModal(
              priceRange: _priceRange,
              onPriceRangeChanged: (RangeValues newRange) {
                setState(() {
                  _priceRange = newRange;
                });
              },
              selectedSortOption: _selectedSortOption,
              sortOptions: _sortOptions,
              onSortOptionChanged: (String newSortOption) {
                setState(() {
                  _selectedSortOption = newSortOption;
                });
              }, 
              onReset: () {  },
              onApply: () {  },
            );
          },
        );
      },
      child: const Icon(Icons.filter_alt_outlined, size: 40, color: Colors.black87),
    );
  }
}
