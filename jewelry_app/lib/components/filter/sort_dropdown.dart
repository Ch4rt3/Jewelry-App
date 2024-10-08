import 'package:flutter/material.dart';

class SortDropdown extends StatefulWidget {
  final String selectedOption;
  final List<String> options;
  final Function(String) onChanged;

  const SortDropdown({
    Key? key,
    required this.selectedOption,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SortDropdownState createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  late String _currentSelection;

  @override
  void initState() {
    super.initState();
    _currentSelection = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          value: _currentSelection,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.black, // O el color que prefieras
          ),
          onChanged: (String? newValue) {
            setState(() {
              _currentSelection = newValue!;
            });
            widget.onChanged(_currentSelection); // Llama a la función que cambia el valor en el padre
          },
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
