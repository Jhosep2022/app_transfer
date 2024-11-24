import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environment/environment.dart';

class WebViewService {
  final String _baseUrl = Environment.baseUrl;

  /// Obtener URL dinámica para WebView
  Future<String?> obtenerUrlWebView() async {
    final Uri url = Uri.parse("$_baseUrl/get-webview-url");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['url']; // Suponemos que el JSON tiene un campo 'url'.
      } else {
        print("Error al obtener URL para WebView: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return null;
    }
  }
}
