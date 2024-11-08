import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class ApiBaseService {
  final String baseUrl = 'http://192.168.19.60:4568'; //IP de Fantino
  // final String baseUrl = 'http://192.168.190.1:4568'; //IP de josias
  

  // Método para manejar solicitudes GET
  Future<http.Response> getRequest(String endpoint) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error al realizar la solicitud: $e');
    rethrow; // Opcionalmente puedes lanzar la excepción para manejarla en otro lugar
  }
}

  // Método para manejar solicitudes POST
  Future<http.Response> postRequest(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),  // Eliminamos la verificación innecesaria
    );
    return response;
  }


  // Puedes agregar más métodos para PUT, DELETE, etc. según sea necesario
}
