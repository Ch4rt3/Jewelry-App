import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:jewelry_app/models/usuario.dart';
import 'package:jewelry_app/services/api_base_service.dart';

class UsuarioService extends ApiBaseService{



 Future<http.Response> updateUsuario(Map<String, dynamic> data) async {
    final String endpoint = '/usuarios/${data['id']}';
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    print('Response: ${response.body}');
    return response;
  }
 


  Future<http.Response> loginUsuario(String email, String contrasena) async {
    try {
      // Crear el cuerpo de la solicitud con las credenciales
      Map<String, dynamic> data = {
        'Email': email,
        'Contrasenia': contrasena,
      };

      // Realizar la solicitud POST al endpoint de login
      final response = await postRequest('/usuarios/login', data);

      // Imprimir la respuesta para depuración
      print('Response: ${response.body}');

      return response;
    } catch (e) {
      print('Error en loginUsuario: $e');
      // Retornar una respuesta de error en lugar de null
      return http.Response(
        jsonEncode({'error': 'Error al iniciar sesión'}),
        500, // Código de estado para errores de servidor
      );
    }
  }

  Future<http.Response> crearUsuario(Usuario usuario) async {
    try {
      // Convertir el objeto Usuario a un mapa para el cuerpo de la solicitud
      Map<String, dynamic> data = usuario.toJson();

      // Realizar la solicitud POST al endpoint de creación de usuario
      final response = await postRequest('/usuarios', data);

      print(data);
      print('Response: ${response.body}');

      return response;
    } catch (e) {
      print('Error en crearUsuario: $e');
      // Retornar una respuesta de error en lugar de null
      return http.Response(
        jsonEncode({'error': 'Error al crear usuario'}),
        500, // Código de estado para errores de servidor
      );
    }
  }

  Future<Map<String, dynamic>> enviarCorreo(String email) async {
    try {
      // Crear el cuerpo de la solicitud con el email en el formato requerido
      Map<String, dynamic> data = {
        "Email": email,
      };

      // Llamar a la función postRequest y pasarle la ruta y los datos
      final response = await postRequest('/usuarios/enviar-correo', data);

      // Verificar el código de estado y retornar el mensaje adecuado en formato Map
      if (response.statusCode == 200) {
        return {
          "message": "Código de recuperación enviado a tu correo",
          "status": 200,
        };
      } else {
        return {
          "message": "Usuario no encontrado",
          "status": 500,
        };
      }
    } catch (e) {
      print('Error en enviarCorreo: $e');

      // Retornar un mensaje de error como Map
      return {
        "message": "Error al enviar correo",
        "status": 500,
      };
    }
  }
  Future<bool> actualizarContrasenia(String email, String nuevaContrasenia, String codigoRecuperacion ) async {
    try {
      // Crear el cuerpo de la solicitud con el email en el formato requerido
      Map<String, dynamic> data = {
        "Email": email,
        "Nueva_contrasenia": nuevaContrasenia,
        "Codigo_recuperacion": codigoRecuperacion
      };

      print(data);

      // Llamar a la función postRequest y pasarle la ruta y los datos
      final response = await postRequest('/usuarios/actualizar-contrasenia', data);

      // Verificar el código de estado y retornar el mensaje adecuado en formato Map
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error al actualizar contraseña: $e');

      return false;
    }
  }
}
