import 'dart:convert';
import 'package:http/http.dart' as http;
import '../environment/environment.dart';
import '../models/consulta_pu_model.dart';

class MostrarDatosService {
  final String _baseUrl = Environment.baseUrl;

  /// Registra una PPU consultada
  Future<bool> registrarPPUConsultada(ConsultaPU consulta) async {
    final Uri url = Uri.parse("$_baseUrl/ppu_consultada.php");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: consulta.toJson(),
      );

      if (response.statusCode == 200) {
        print("PPU registrada correctamente.");
        return true;
      } else {
        print("Error al registrar PPU: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }

  /// Enviar correo PPU consultada
  Future<void> enviarCorreoPPUConsultada(String rutUsuario) async {
    final Uri url = Uri.parse("$_baseUrl/Correo_ppu_consultada.php?rut_usuario=$rutUsuario");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Correo enviado correctamente.");
      } else {
        print("Error al enviar correo: ${response.body}");
      }
    } catch (e) {
      print("Error de conexión: $e");
    }
  }

  /// Enviar correos de aviso de vehículos
  Future<void> enviarCorreoAviso(String patenteCivil) async {
    final Uri url = Uri.parse("$_baseUrl/CorreoVehiculos.php?patentecivil=$patenteCivil");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("Correo de aviso enviado correctamente.");
      } else {
        print("Error al enviar correo de aviso: ${response.body}");
      }
    } catch (e) {
      print("Error de conexión: $e");
    }
  }

  /// Agregar PPU a la base de datos interna
  Future<bool> agregarPatente(Map<String, String> datosPatente) async {
    final Uri url = Uri.parse("$_baseUrl/agrega_ppu.php");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: datosPatente,
      );

      if (response.statusCode == 200) {
        print("Patente agregada correctamente.");
        return true;
      } else {
        print("Error al agregar patente: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }

  /// Grabar consultas realizadas
  Future<bool> grabarConsultas(Map<String, String> datosConsulta) async {
    final Uri url = Uri.parse("$_baseUrl/MasConsultas.php");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: datosConsulta,
      );

      if (response.statusCode == 200) {
        print("Consulta grabada correctamente.");
        return true;
      } else {
        print("Error al grabar consulta: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }

  /// Consultar chasis en Registro Civil
  Future<Map<String, dynamic>?> consultarChasisRegistroCivil(String chasisCivil) async {
    final Uri url = Uri.parse("$_baseUrl/ConsultaChasisRegistroCivil.php?chasiscivil=$chasisCivil");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          return data[0];
        } else {
          print("Chasis no encontrado.");
          return null;
        }
      } else {
        print("Error al consultar chasis: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return null;
    }
  }

  /// Consultar patente en registro interno
  Future<Map<String, dynamic>?> consultarRegistroInterno(String patenteCivil) async {
    final Uri url = Uri.parse("$_baseUrl/buscarregistrocivil.php?patentecivil=$patenteCivil");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          return data[0];
        } else {
          print("Registro interno no encontrado.");
          return null;
        }
      } else {
        print("Error al consultar registro interno: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return null;
    }
  }

  /// Actualizar estado de "verificado"
  Future<bool> actualizarVerificado(String rutUsuario, String verificado) async {
    final Uri url = Uri.parse("$_baseUrl/cambia_verificado.php");
    final body = {
      "rut_usuario": rutUsuario,
      "verificado": verificado,
    };

    try {
      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        print("Estado de verificado actualizado.");
        return true;
      } else {
        print("Error al actualizar verificado: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error de conexión: $e");
      return false;
    }
  }
}
