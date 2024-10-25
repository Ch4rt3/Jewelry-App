import 'package:flutter/material.dart';
import 'package:jewelry_app/components/filter/filter_action_buttons.dart';
import 'package:jewelry_app/components/filter/price_ranger.dart';
import 'package:jewelry_app/components/filter/sort_dropdown.dart';
import 'package:jewelry_app/configs/colors.dart';

class FilterModal extends StatelessWidget {
  final RangeValues priceRange;
  final Function(RangeValues) onPriceRangeChanged;
  final String selectedSortOption;
  final List<String> sortOptions;
  final Function(String) onSortOptionChanged;
  final VoidCallback onReset; // Función para manejar el reset
  final VoidCallback onApply; // Función para manejar el apply

  const FilterModal({
    super.key,
    required this.priceRange,
    required this.onPriceRangeChanged,
    required this.selectedSortOption,
    required this.sortOptions,
    required this.onSortOptionChanged,
    required this.onReset, // Recibimos la función de reset
    required this.onApply, // Recibimos la función de apply
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85, // El tamaño inicial del modal
      minChildSize: 0.5, // El tamaño mínimo cuando se minimiza
      maxChildSize: 0.9, // El tamaño máximo cuando se expande
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sección centrada con drag_handle y Filter
                const Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.drag_handle, color: Colors.grey, size: 30),
                      SizedBox(height: 10),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Sección alineada a la izquierda para los textos y dropdown
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Price Range",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      PriceRangeSlider(
                        initialRange: priceRange,
                        onChanged: onPriceRangeChanged,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Sort By",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SortDropdown(
                        selectedOption: selectedSortOption,
                        options: sortOptions,
                        onChanged: onSortOptionChanged,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Usar el componente ActionButtons aquí
                ActionButtons(
                  onReset: onReset,
                  onApply: onApply,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
