import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/registro_usuario_screen.dart';
import 'package:transfer_app/services/infor6_crea6_service.dart';
import 'dart:math'; // Para generar números aleatorios
import 'package:intl/intl.dart'; // Para formatear la hora
import 'codigo_verificacion_screen.dart';

class ConfirmarCorreoScreen extends StatelessWidget {
  final String email;
  final String rut;
  final String region;
  final String ciudad;
  final String comuna;
  final String claveLocal;
  final Infor6Crea6Service _usuarioService = Infor6Crea6Service(); // Instancia del servicio

  ConfirmarCorreoScreen({
    required this.email,
    required this.rut,
    required this.region,
    required this.ciudad,
    required this.comuna,
    required this.claveLocal,
    });

  // Método para generar los parámetros (similar al código proporcionado)
  Future<void> _enviarClave(BuildContext context) async {
    String rutCliente = rut;
    int numeroClave = _generarNumero(); // Número aleatorio
    String horaVerificacion = _obtenerHoraActual();

    print("Parámetros generados:");
    print("RUT: $rutCliente");
    print("Clave: $numeroClave");
    print("Hora: $horaVerificacion");

    // Llamar al servicio para almacenar la clave
    bool resultado = await _usuarioService.almacenarClave(
      rutCliente,
      numeroClave,
      horaVerificacion,
    );

    if (resultado) {
      print("Clave almacenada con éxito.");
      _enviarCorreo(context, numeroClave.toString());
    } else {
      print("Error al almacenar la clave.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al confirmar el correo. Inténtalo de nuevo.")),
      );
    }
  }

  // Método para ir a la pantalla de confirmación
  Future<void> _irConfirmacion(BuildContext context, String numClave) async {
    try {
      await _usuarioService.enviarCorreoConfirmacion(rut);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CodigoVerificacionScreen(
          email: email,
          rut: rut,
          clave: numClave,
        )),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al confirmar el correo: $e")),
      );
    }
  }

  // Método para enviar correo de confirmación
  Future<void> _enviarCorreo(BuildContext context, String numClave) async {
    try {
      await _usuarioService.enviarCorreoConfirmacion(rut);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Region guardada exitosamente.")),
      );
      _irConfirmacion(context, numClave);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar el usuario: $e")),
      );
    }
  }

  // Método para generar un número aleatorio
  int _generarNumero() {
    return 100000 + Random().nextInt(900000); // Número aleatorio de 6 dígitos
  }

  // Método para obtener la hora actual
  String _obtenerHoraActual() {
    DateTime now = DateTime.now();
    return DateFormat('h:mm:ss').format(now).trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cabecera curvada con diseño
          Stack(
            children: [
              ClipPath(
                clipper: InvertedHeaderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.23*0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0*0.75),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '¿Es tu correo?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),

          // Icono y texto
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                size: 80,
                color: Colors.teal,
              ),
              SizedBox(height: 20),
              Text(
                '¿Es tu correo?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                child: Text(
                  'Si confirmas, te enviaremos un código de 6 dígitos',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                email,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Spacer(),

          // Botón de Confirmación
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _enviarClave(context), // Llamada al servicio
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'CONFIRMO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          // Botón de Confirmación
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroUsuarioScreen(
                      clave: claveLocal,
                      region: region,
                      comuna: comuna,
                      ciudad: ciudad,
                    )),
                  ),
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '¿No es tu correo?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}