import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/vehiculos_service.dart';
import 'crear_clave_ingreso_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ERutScannerScreen extends StatefulWidget {
  @override
  _ERutScannerScreenState createState() => _ERutScannerScreenState();
}

class _ERutScannerScreenState extends State<ERutScannerScreen> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "";
  String resultMessage = "";
  bool isLoading = false;

  final VehiculosService _vehiculosService = VehiculosService();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller != null) {
      if (state == AppLifecycleState.paused) {
        controller!.pauseCamera();
      } else if (state == AppLifecycleState.resumed) {
        controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear E-RUT'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
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
                if (isLoading)
                  const CircularProgressIndicator()
                else if (resultMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      resultMessage,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: resultMessage.contains('Verificado') ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _navigateToCrearClaveIngresoScreen();
                  },
                  child: const Text('Volver'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera(); // Pausar la cámara para evitar lecturas duplicadas
      setState(() {
        qrText = scanData.code!;
      });

      print("Contenido del QR: $qrText");
      _processQR(qrText);
    });
  }

  Future<void> _processQR(String qrData) async {
    setState(() {
      isLoading = true;
    });

    try {
      final Map<String, dynamic> qrDataDecoded = json.decode(qrData);
      final String rut = qrDataDecoded['rut'] ?? '';
      final String dv = qrDataDecoded['dv'] ?? '';
      final String rutEscaneado = '$rut-$dv';
      final String serie = qrDataDecoded['serie'] ?? '';
      final String razonSocial = qrDataDecoded['razonSocial'] ?? '';
      final String direccionScanned = qrDataDecoded['direccion'] ?? '';

      if (rut.isEmpty || dv.isEmpty || serie.isEmpty || razonSocial.isEmpty) {
        setState(() {
          resultMessage = 'Datos del QR incompletos.';
        });
        controller?.resumeCamera();
        return;
      }

      _mostrarDialogoDatosQR(rut, dv, serie, razonSocial);
      await _saveToLocalStorage(rutEscaneado, rut, serie, direccionScanned, razonSocial);
      setState(() {
        resultMessage = 'E-RUT Verificado y Guardado Localmente.';
      });

      _navigateToCrearClaveIngresoScreen();
    } catch (e) {
      setState(() {
        resultMessage = 'Error al procesar el QR.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _navigateToCrearClaveIngresoScreen() {
    controller?.stopCamera();
    controller?.dispose(); // Detener y liberar la cámara
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CrearClaveIngresoScreen()),
    );
  }

  void _mostrarDialogoDatosQR(String rut, String dv, String serie, String razonSocial) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Datos del QR Escaneado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('RUT: $rut-$dv'),
              Text('Serie: $serie'),
              Text('Razón Social: $razonSocial'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller?.resumeCamera();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveToLocalStorage(String rutScanned, String rut, String serie, String direccion, String razonSocial) async {
    await secureStorage.write(key: 'rut', value: rut);
    await secureStorage.write(key: 'serie', value: serie);
    await secureStorage.write(key: 'razonSocial', value: razonSocial);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rut', rutScanned);
    await prefs.setString('serial', serie);
    await prefs.setString('tipo', "2");
    await prefs.setString('direccion', direccion);
    await prefs.setString('razonSocial', razonSocial);
    await prefs.setString('contador', "4");
    await prefs.setString('monedavende', r"$");
    await prefs.setString('vendeenviadatos', "");
    await prefs.setString('primero', "");
  }
}
