import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environment/environment.dart';

class ClaveRemotaService {
  final String baseUrl = Environment.baseUrl;

  // Actualizar clave remota
  Future<bool> actualizarClaveRemota(String rutUsuario, String claveRemota) async {
    final url = Uri.parse('$baseUrl/ActualizaClaveInternet.php');
    try {
      final response = await http.post(
        url,
        body: {
          'rut_usuario': rutUsuario,
          'clave_remota': claveRemota,
        },
      );

      if (response.statusCode == 200) {
        print("Clave remota actualizada exitosamente.");
        return true;
      } else {
        print("Error al actualizar clave remota: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
      return false;
    }
  }
}
