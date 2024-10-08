import 'package:flutter/material.dart';

class PriceRangeSlider extends StatefulWidget {
  final RangeValues initialRange;
  final Function(RangeValues) onChanged;

  const PriceRangeSlider({
    Key? key,
    required this.initialRange,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();
    _currentRange = widget.initialRange; // Inicializa con el rango inicial
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: _currentRange,
          min: 0,
          max: 100,
          divisions: 10,
          labels: RangeLabels(
            '\$${_currentRange.start.round()}',
            '\$${_currentRange.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRange = values;
            });
            widget.onChanged(values); // Llama a la función pasada desde el padre
          },
        ),
        const SizedBox(height: 10),
        Text(
          'Selected range: \$${_currentRange.start.round()} - \$${_currentRange.end.round()}',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}
