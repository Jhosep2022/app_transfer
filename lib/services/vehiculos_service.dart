import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transfer_app/environment/environment.dart';
import '../models/vehiculo_model.dart';

class VehiculosService {
  final String baseUrl = Environment.baseUrl;

  // Consultar un vehículo en el Registro Civil
  Future<Vehiculo?> consultarRegistroCivil(String patente) async {
    final url = Uri.parse('$baseUrl/ConsultaRegistroCivil.php?patentecivil=$patente');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          print("Vehículo encontrado en el registro civil xdxdxd. $data");
          return Vehiculo.fromJson(data[0]);
        }else{
          print("Vehículo no encontrado en el registro civil xdxdxd.");
        }
      }
    } catch (e) {
      print("Error al consultar el registro civil: $e");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          print("Vehículo encontrado en el registro civil zzzz. $data");
          return Vehiculo.fromJson(data[0]);
        }else{
          print("Vehículo no encontrado en el registro civil zzzz.");
        }
      }
    }
    return null;
  }

  // Consultar vehículo en el registro interno
  Future<Vehiculo?> consultarRegistroInterno(String patente) async {
    final url = Uri.parse('$baseUrl/buscarregistrocivil.php?patentecivil=$patente');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return Vehiculo.fromJson(data[0]);
        }
      }
    } catch (e) {
      print("Error al consultar el registro interno: $e");
    }
    return null;
  }

  //agregarsistema
  //VerificaRut

  // Agregar vehículo al registro interno
  Future<void> agregarRegistroInterno(Map<String, String> params) async {
    final url = Uri.parse('$baseUrl/ingresaRCinterno.php');
    try {
      final response = await http.post(
        url,
        body: params,
      );
      if (response.statusCode == 200) {
        print("Vehículo agregado exitosamente.");
      } else {
        print("Error al agregar vehículo: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  // Actualizar el estado de un vehículo
  Future<void> actualizarVehiculo(Map<String, String> params) async {
    final url = Uri.parse('$baseUrl/editar_vehiculo.php');
    try {
      final response = await http.post(
        url,
        body: params,
      );
      if (response.statusCode == 200) {
        print("Vehículo actualizado exitosamente.");
      } else {
        print("Error al actualizar vehículo: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  // Consultar si un vehículo está en el aparcadero
  Future<bool> consultarAparcadero(String patente) async {
    final url = Uri.parse('$baseUrl/BuscaEnAparcadero.php?patente_aparcada=$patente');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.isNotEmpty;
      }
    } catch (e) {
      print("Error al consultar el aparcadero: $e");
    }
    return false;
  }

  // Grabar consultas en el historial
  Future<void> grabarConsulta(Map<String, String> params) async {
    final url = Uri.parse('$baseUrl/MasConsultas.php');
    try {
      final response = await http.post(
        url,
        body: params,
      );
      if (response.statusCode == 200) {
        print("Consulta grabada exitosamente.");
      } else {
        print("Error al grabar consulta: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  // Cambiar verificación del usuario
  Future<void> cambiarVerificado(String rutUsuario) async {
    final url = Uri.parse('$baseUrl/cambia_verificado.php');
    try {
      final response = await http.post(
        url,
        body: {'rut_usuario': rutUsuario, 'verificado': 'No'},
      );
      if (response.statusCode == 200) {
        print("Verificación cambiada exitosamente.");
      } else {
        print("Error al cambiar verificación: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  // Agregar un vehículo al sistema
  Future<void> agregaAsistema(String patente) async {
    final url = Uri.parse('$baseUrl/agregaAsistema.php');
    try {
      final response = await http.post(
        url,
        body: {'patentecivil': patente, 'ssistema': 'Si'},
      );
      if (response.statusCode == 200) {
        print("Vehículo agregado al sistema exitosamente.");
      } else {
        print("Error al agregar vehículo al sistema: ${response.body}");
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
  }

  // Verificar si un usuario está autorizado
  Future<Map<String, String>?> verificaRut(String rutUsuario) async {
    final String baseUrl = Environment.baseUrl;
    final url = Uri.parse('$baseUrl/VerificaRut.php?rut_usuario=$rutUsuario');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final json = data[0] as Map<String, dynamic>;
          return {
            'verificado': json['verificado'] ?? '',
            'activo': json['activo'] ?? '',
          };
        }
      }
    } catch (e) {
      print("Error al realizar la solicitud: $e");
    }
    return null;
  }

}
