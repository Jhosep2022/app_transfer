import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environment/environment.dart';
import '../models/ubicar_request.dart';

class UbicarService {
  final String _baseUrl = Environment.baseUrl;

  /// Enviar datos para ubicar un vehículo
  Future<bool> enviarUbicar(UbicarRequest request) async {
    final Uri url = Uri.parse("$_baseUrl/ubicar.php");

    try {
      final response = await http.post(
        url,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        print("Ubicación enviada correctamente.");
        return true;
      } else {
        print("Error al enviar ubicación: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }

  /// Enviar datos de duplicado de patente
  Future<bool> enviarDuplicar(Map<String, String> duplicarRequest) async {
    final Uri url = Uri.parse("$_baseUrl/duplicar.php");

    try {
      final response = await http.post(
        url,
        body: duplicarRequest,
      );

      if (response.statusCode == 200) {
        print("Duplicado enviado correctamente.");
        return true;
      } else {
        print("Error al enviar duplicado: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }

  /// Enviar datos cuando el usuario no tiene la app
  Future<bool> enviarSinApp(Map<String, String> sinAppRequest) async {
    final Uri url = Uri.parse("$_baseUrl/Sin_App.php");

    try {
      final response = await http.post(
        url,
        body: sinAppRequest,
      );

      if (response.statusCode == 200) {
        print("SinApp enviado correctamente.");
        return true;
      } else {
        print("Error al enviar SinApp: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }

  /// Agregar coordenadas
  Future<bool> agregarCoordenadas(Map<String, String> coordenadasRequest) async {
    final Uri url = Uri.parse("$_baseUrl/agregacoordenadas.php");

    try {
      final response = await http.post(
        url,
        body: coordenadasRequest,
      );

      if (response.statusCode == 200) {
        print("Coordenadas agregadas correctamente.");
        return true;
      } else {
        print("Error al agregar coordenadas: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }
}
