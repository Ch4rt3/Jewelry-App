import 'dart:convert';
import '../models/pais.dart';
import 'api_base_service.dart';

class PaisService extends ApiBaseService {
  // Obtener todos los países
  Future<List<Pais>> fetchPaises() async {
    final String endpoint = '/paises';
    final response = await getRequest(endpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Pais.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los países');
    }
  }
}
