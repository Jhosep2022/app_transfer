import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environment/environment.dart';
import '../models/aparcadero_model.dart';

class AparcaderoService {
  Future<Aparcadero?> fetchAparcadero(String patenteAparcada) async {
    final url = Uri.parse('${Environment.baseUrl}/BuscaEnAparcadero.php?patente_aparcada=$patenteAparcada');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty) {
          return Aparcadero.fromJson(jsonData[0]);
        }
      }
    } catch (e) {
      print("Error fetching aparcadero: $e");
    }
    return null;
  }

  Future<void> sendCorreoAparcadero(String patenteAparcada) async {
    final url = Uri.parse('${Environment.baseUrl}/CorreoAvisoAparcadero.php?patente_aparcada=$patenteAparcada');
    try {
      await http.get(url);
    } catch (e) {
      print("Error sending correo aparcadero: $e");
    }
  }
}
