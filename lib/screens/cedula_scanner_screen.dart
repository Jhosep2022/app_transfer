import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:transfer_app/screens/crear_clave_ingreso_screen.dart';

class CedulaScannerScreen extends StatefulWidget {
  @override
  _CedulaScannerScreenState createState() => _CedulaScannerScreenState();
}

class _CedulaScannerScreenState extends State<CedulaScannerScreen> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  String _qrText = "";
  String? runEscaneado;
  String? serialEscaneado;
  String? tipoEscaneado;
  String _resultado = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller != null) {
      if (state == AppLifecycleState.paused) {
        _controller!.pauseCamera();
      } else if (state == AppLifecycleState.resumed) {
        _controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Cédula de Identidad'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else if (_resultado.isNotEmpty)
                  Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _resultado.contains('Verificado') ? Colors.green : Colors.red,
                    ),
                  ),
                if (!_isLoading && _resultado.isEmpty)
                  const Text(
                    'Escanea un código QR para verificar el RUT.',
                    style: TextStyle(fontSize: 14),
                  ),
                const SizedBox(height: 20),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Inicializa el escáner QR
  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      _controller?.pauseCamera(); // Pausa la cámara para evitar lecturas duplicadas
      setState(() {
        _qrText = scanData.code ?? "";
      });

      // Imprimir contenido del QR en la consola
      print("Contenido del QR escaneado: $_qrText");

      // Procesar la URL del QR para extraer los valores
      _procesarQR(_qrText);

      // Reanudar la cámara después de un tiempo
      Future.delayed(const Duration(seconds: 3), () {
        _controller?.resumeCamera();
      });
    });
  }

  /// Procesa el contenido del QR para extraer datos clave
  void _procesarQR(String qrData) async {
    try {
      final uri = Uri.parse(qrData);

      if (uri.queryParameters['RUN'] == "" || uri.queryParameters['serial'] == "" || uri.queryParameters['type'] == "") {
        setState(() {
          _resultado = 'Datos del QR incompletos.';
        });
        return;
      }

      // Extraer valores de los parámetros de la URL
      setState(() {
        runEscaneado = uri.queryParameters['RUN'];
        serialEscaneado = uri.queryParameters['serial'];
        tipoEscaneado = uri.queryParameters['type'];
      });

      // Imprimir los valores en la consola para depuración
      print("RUN: $runEscaneado");
      print("Serial: $serialEscaneado");
      print("Tipo: $tipoEscaneado");

      // Guardar los datos en SharedPreferences
      await _guardarDatos(runEscaneado, serialEscaneado, tipoEscaneado);

      // Navegar a la siguiente pantalla
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CrearClaveIngresoScreen()),
      );
    } catch (e) {
      print("Error al procesar QR: $e");
      _resultado = 'Error al procesar el QR.';
    }
  }

  /// Guarda los datos escaneados en SharedPreferences
  Future<void> _guardarDatos(String? run, String? serial, String? tipo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rut', run ?? "No disponible");
    await prefs.setString('serie', serial ?? "No disponible");
    await prefs.setString('tipo', "1");
  }

  /// Valida el RUT llamando al servicio
  Future<void> _verificarRut(String qrData) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Extrae el RUT del QR (adaptado a la estructura esperada)
      String? rut = runEscaneado;
      if (rut == null) {
        setState(() {
          _resultado = "Error: QR no contiene un RUT válido.";
          _isLoading = false;
        });
        return;
      }

      // Llama al servicio para verificar el RUT
      final response = await http.get(Uri.parse(
          'https://certivip.com/VerificaRut.php?rut_usuario=$rut'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _resultado = (data != null && data.length > 0)
              ? "RUT Verificado: Activo"
              : "RUT no encontrado o no activo.";
        });
      } else {
        setState(() {
          _resultado = "Error en la conexión al servicio.";
        });
      }
    } catch (e) {
      setState(() {
        _resultado = "Error: No se pudo procesar la solicitud.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _controller?.resumeCamera();
    }
  }
}
