import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tarjeta.dart';
import '../services/wallet_service.dart';

class WalletProvider extends ChangeNotifier {
  List<Tarjeta> _tarjetas = [];
  final WalletService _walletService = WalletService();

  List<Tarjeta> get tarjetas => _tarjetas;

  WalletProvider() {
    loadTarjetas();
  }

  // Cargar tarjetas desde la API
  Future<void> loadTarjetas() async {
    try {
      // Obtener el usuarioId del SharedPreferences
      final usuarioId = await _obtenerUsuarioId();

      if (usuarioId == null) {
        print("Error: usuarioId no encontrado en SharedPreferences.");
        return;
      }

      // Intentar obtener las tarjetas del servicio usando usuarioId
      _tarjetas = await _walletService.getWalletsByUserId(usuarioId);
      notifyListeners();
    } catch (e) {
      print('Error al cargar tarjetas: $e');
    }
  }

  // Método auxiliar para obtener usuarioId como String
  Future<String?> _obtenerUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // Agregar una nueva tarjeta
  Future<void> addTarjeta(Tarjeta tarjeta) async {
    final usuarioId = await _obtenerUsuarioId();

    if (usuarioId == null) {
      print("Error: usuarioId no encontrado en SharedPreferences.");
      return;
    }

    tarjeta.usuarioId = usuarioId;

    final response = await _walletService.createWallet(tarjeta);

    if (response.statusCode == 201) {
      _tarjetas.add(tarjeta);
      notifyListeners();
    } else {
      print('Error al agregar tarjeta: ${response.body}');
    }
  }

  // Eliminar una tarjeta
  Future<void> deleteTarjeta(int id) async {
    final response = await _walletService.deleteWallet(id);
    if (response.statusCode == 200) {
      _tarjetas.removeWhere((tarjeta) => tarjeta.id == id);
      notifyListeners();
    } else {
      print('Error al eliminar tarjeta: ${response.body}');
    }
  }
}
