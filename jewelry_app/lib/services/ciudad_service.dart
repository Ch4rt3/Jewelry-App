import 'dart:convert';
import '../models/ciudad.dart';
import 'api_base_service.dart';

class CiudadService extends ApiBaseService {
  // Obtener todas las ciudades de un país específico
  Future<List<Ciudad>> fetchCiudadesByPaisId(int paisId) async {
    final String endpoint = '/ciudades/pais/$paisId';
    final response = await getRequest(endpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Ciudad.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener las ciudades');
    }
  }
}
