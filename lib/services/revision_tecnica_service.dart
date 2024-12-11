import 'dart:convert';
import 'package:http/http.dart' as http;

class RevisionTecnicaService {
  Future<String> fetchHtml(String ppu) async {
    final url = Uri.parse('https://www.prt.cl/Paginas/QRRevisionTecnica.aspx?patente=$ppu');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Retorna el HTML del servicio
      return response.body;
    } else {
      throw Exception('Error al obtener el HTML: ${response.statusCode}');
    }
  }
}
