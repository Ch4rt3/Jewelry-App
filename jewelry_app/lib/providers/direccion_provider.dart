import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/direccion.dart';
import '../services/direccion_service.dart';

class DireccionProvider extends ChangeNotifier {
  final DireccionService _direccionService = DireccionService();
  List<Direccion> _direcciones = [];
  int? _usuarioId;

  List<Direccion> get direcciones => _direcciones;

  DireccionProvider() {
    // Cargar usuarioId automáticamente al inicializar el provider
    loadUsuarioId();
  }

  // Cargar el usuarioId desde SharedPreferences
  Future<void> loadUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    _usuarioId = prefs.getInt('userId');
    if (_usuarioId != null) {
      await fetchDirecciones();
    }
  }

  // Obtener direcciones desde el servicio
  Future<void> fetchDirecciones() async {
    if (_usuarioId == null) return;

    try {
      _direcciones = await _direccionService.fetchDireccionesByUsuarioId(_usuarioId!);
      notifyListeners();
    } catch (e) {
      print('Error al cargar las direcciones: $e');
    }
  }

  // Crear una nueva dirección
  Future<void> addDireccion(Direccion direccion) async {
    try {
      final nuevaDireccion = await _direccionService.createDireccion(direccion);
      _direcciones.add(nuevaDireccion);
      notifyListeners();
    } catch (e) {
      print('Error al agregar la dirección: $e');
    }
  }

  // Eliminar una dirección
  Future<void> deleteDireccion(int id) async {
    try {
      await _direccionService.deleteDireccion(id);
      _direcciones.removeWhere((direccion) => direccion.id == id);
      notifyListeners();
    } catch (e) {
      print('Error al eliminar la dirección: $e');
    }
  }
}
