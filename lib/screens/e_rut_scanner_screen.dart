import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/vehiculos_service.dart';
import 'crear_clave_ingreso_screen.dart';

class ERutScannerScreen extends StatefulWidget {
  @override
  _ERutScannerScreenState createState() => _ERutScannerScreenState();
}

class _ERutScannerScreenState extends State<ERutScannerScreen> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "";
  String resultMessage = "";

  final VehiculosService _vehiculosService = VehiculosService();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Observador para el ciclo de vida
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Quitar el observador
    controller?.dispose(); // Liberar recursos de la cámara
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller != null) {
      if (state == AppLifecycleState.paused) {
        controller!.pauseCamera(); // Pausa la cámara si la app está en segundo plano
      } else if (state == AppLifecycleState.resumed) {
        controller!.resumeCamera(); // Reanuda la cámara si la app vuelve al primer plano
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
                Text(
                  'Código escaneado: $qrText',
                  style: const TextStyle(fontSize: 18),
                ),
                if (resultMessage.isNotEmpty)
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
                    controller?.stopCamera(); // Detén la cámara antes de navegar
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CrearClaveIngresoScreen()),
                    );
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
      controller.pauseCamera(); // Pausa la cámara para evitar lecturas duplicadas
      setState(() {
        qrText = scanData.code!;
      });
      _processQR(qrText);
    });
  }

  Future<void> _processQR(String qrData) async {
    try {
      final Uri parsedQR = Uri.parse(qrData);
      final String rut = parsedQR.queryParameters['rut'] ?? '';
      final String serie = parsedQR.queryParameters['serie'] ?? '';

      if (rut.isEmpty || serie.isEmpty) {
        setState(() {
          resultMessage = 'Datos del QR incompletos.';
        });
        controller?.resumeCamera();
        return;
      }

      final result = await _vehiculosService.verificaRut(rut);
      if (result != null && result['activo'] == 'true') {
        await _saveToLocalStorage(rut, serie, result['verificado'] ?? '');
        setState(() {
          resultMessage = 'RUT Verificado y Guardado Localmente';
        });
      } else {
        setState(() {
          resultMessage = 'RUT no verificado.';
        });
      }
    } catch (e) {
      setState(() {
        resultMessage = 'Error al procesar el QR.';
      });
    } finally {
      controller?.resumeCamera();
    }
  }

  Future<void> _saveToLocalStorage(String rut, String serie, String verificado) async {
    await secureStorage.write(key: 'rut', value: rut);
    await secureStorage.write(key: 'serie', value: serie);
    await secureStorage.write(key: 'verificado', value: verificado);
  }
}
