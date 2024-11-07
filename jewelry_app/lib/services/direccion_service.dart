import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/direccion.dart';
import 'api_base_service.dart';

class DireccionService extends ApiBaseService {
  // Fetch all addresses for a specific user by ID
  Future<List<Direccion>> fetchDireccionesByUsuarioId(int usuarioId) async {
    final String endpoint = '/direcciones/usuario/$usuarioId';
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Direccion.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener las direcciones');
    }
  }

  // Create a new address and return the Direccion object
  Future<Direccion> createDireccion(Direccion direccion) async {
    final String endpoint = '/direcciones';
    final data = direccion.toJson();
    print('Datos enviados al servidor: $data'); // Check data before sending

    final response = await postRequest(endpoint, data);

    if (response.statusCode == 201) {
      // Parse and return the Direccion from response body
      return Direccion.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear la dirección');
    }
  }

  // Delete an address by ID
  Future<void> deleteDireccion(int id) async {
    final String endpoint = '/direcciones/$id';
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la dirección');
    }
  }
}
