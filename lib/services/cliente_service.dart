import 'dart:convert';
import 'package:http/http.dart' as http;

import '../environment/environment.dart';

class ClienteService {
  final String baseUrl = Environment.baseUrl;

  Future<void> agregarUsuario(Map<String, String> params) async {
    final url = Uri.parse('$baseUrl/validarut.php');
    try {
      final response = await http.post(
        url,
        body: params,
      );
      if (response.statusCode == 200) {
        print("Usuario agregado exitosamente.");
      } else {
        print("Error al agregar usuario: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  Future<void> agregarRegionCliente(Map<String, String> params) async {
    final url = Uri.parse('$baseUrl/regionrut.php');
    try {
      final response = await http.post(
        url,
        body: params,
      );
      if (response.statusCode == 200) {
        print("Región de cliente registrada exitosamente.");
      } else {
        print("Error al registrar región del cliente: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  Future<void> enviarCorreoOperador(String rutCliente) async {
    final url = Uri.parse('$baseUrl/CorreoAoperador.php?rut_usuario=$rutCliente');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Correo enviado exitosamente.");
      } else {
        print("Error al enviar correo: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }
}
