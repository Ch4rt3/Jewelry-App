import 'package:flutter/material.dart';
import '../models/ciudad.dart';
import '../services/ciudad_service.dart';

class CiudadProvider extends ChangeNotifier {
  final CiudadService _ciudadService = CiudadService();
  List<Ciudad> _ciudades = [];

  List<Ciudad> get ciudades => _ciudades;

  // Método para cargar las ciudades de un país específico
  Future<void> fetchCiudadesByPaisId(int paisId) async {
    try {
      _ciudades = await _ciudadService.fetchCiudadesByPaisId(paisId);
      notifyListeners();
    } catch (e) {
      print('Error al cargar las ciudades: $e');
    }
  }
}
