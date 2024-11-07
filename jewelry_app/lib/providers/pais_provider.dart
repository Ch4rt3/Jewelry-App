import 'package:flutter/material.dart';
import '../models/pais.dart';
import '../services/pais_service.dart';

class PaisProvider extends ChangeNotifier {
  final PaisService _paisService = PaisService();
  List<Pais> _paises = [];

  List<Pais> get paises => _paises;

  // Método para cargar los países
  Future<void> fetchPaises() async {
    try {
      _paises = await _paisService.fetchPaises();
      notifyListeners();
    } catch (e) {
      print('Error al cargar los países: $e');
    }
  }
}
