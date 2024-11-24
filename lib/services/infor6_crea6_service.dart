import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environment/environment.dart';


class Infor6Crea6Service {
  final String baseUrl = Environment.baseUrl;

  /// Almacena la clave de verificación en el servidor
  Future<bool> almacenarClave(String rutCliente, int numeroClave, String horaVerificacion) async {
    final url = Uri.parse('$baseUrl/usuarioclave.php');
    try {
      final response = await http.post(
        url,
        body: {
          'rutverificacion': rutCliente.trim(),
          'claveverificacion': numeroClave.toString(),
          'horaverificacion': horaVerificacion,
        },
      );
      if (response.statusCode == 200) {
        print("Clave almacenada exitosamente.");
        return true;
      } else {
        print("Error al almacenar clave: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
      return false;
    }
  }

  /// Envía un correo de confirmación al cliente
  Future<bool> enviarCorreoConfirmacion(String rutCliente) async {
    final url = Uri.parse('$baseUrl/CorreoConfirmado.php?rut_usuario=${rutCliente.trim()}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Correo de confirmación enviado.");
        return true;
      } else {
        print("Error al enviar correo de confirmación: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
      return false;
    }
  }

  /// Elimina al usuario de la base de datos
  Future<bool> eliminarUsuario(String rutCliente) async {
    final url = Uri.parse('$baseUrl/Elimina_Usuario.php?rut_usuario=${rutCliente.trim()}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Usuario eliminado exitosamente.");
        return true;
      } else {
        print("Error al eliminar usuario: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
      return false;
    }
  }
}
