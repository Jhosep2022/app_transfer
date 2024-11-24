import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environment/environment.dart';

class DesinstalacionService {
  final String _baseUrl = Environment.baseUrl;

  /// Registra la desinstalación de la aplicación
  Future<bool> registrarDesinstalacion({
    required String rutInstal,
    required String tipoInstal,
    required String correoInstal,
    required String claveInstal,
    required String fechaInstal,
    required String horaInstal,
    required String regionInstal,
    required String comunaInstal,
  }) async {
    final Uri url = Uri.parse("$_baseUrl/Registra_Desinstal.php");
    Map<String, String> body = {
      "rut_instal": rutInstal,
      "tipo_instal": tipoInstal,
      "correoinstal": correoInstal,
      "claveinstal": claveInstal,
      "fechainstal": fechaInstal,
      "horainstal": horaInstal,
      "fechaactual": DateTime.now().toIso8601String(),
      "regioninstal": regionInstal,
      "comunainstal": comunaInstal,
    };

    try {
      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        print("Desinstalación registrada correctamente.");
        return true;
      } else {
        print("Error al registrar desinstalación: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }
}
