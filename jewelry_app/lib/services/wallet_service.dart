import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jewelry_app/models/tarjeta.dart';
import 'package:jewelry_app/services/api_base_service.dart';

class WalletService extends ApiBaseService {
  // Método para crear una nueva tarjeta
  Future<http.Response> createWallet(Tarjeta tarjeta) async {
    final String endpoint = '/wallets';
    final data = tarjeta.toJson();
    print('Datos enviados al servidor: $data'); // Verificar contenido antes de enviar

    final response = await postRequest(endpoint, data);
    print('Response: ${response.body}');
    return response;
  }

  // Método para obtener todas las tarjetas de un usuario específico
  Future<List<Tarjeta>> getWalletsByUserId(String usuarioId) async {
    final String endpoint = '/wallets/usuario/$usuarioId';
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    print('Response: ${response.body}');
    
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Tarjeta.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener las tarjetas');
    }
  }

  // Método para eliminar una tarjeta por ID
  Future<http.Response> deleteWallet(int id) async {
    final String endpoint = '/wallets/$id';
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
    print('Response: ${response.body}');
    return response;
  }
}
