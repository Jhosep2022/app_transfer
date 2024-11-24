import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Cambiamos a flutter_secure_storage
import '../services/vehiculos_service.dart';

class ERutScannerScreen extends StatefulWidget {
  @override
  _ERutScannerScreenState createState() => _ERutScannerScreenState();
}

class _ERutScannerScreenState extends State<ERutScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "";
  String resultMessage = "";

  final VehiculosService _vehiculosService = VehiculosService();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage(); // Instancia para almacenamiento seguro

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
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
                  onPressed: () => Navigator.pop(context),
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
      controller.pauseCamera(); // Pausar para evitar lecturas duplicadas
      setState(() {
        qrText = scanData.code!;
      });
      _processQR(qrText);
    });
  }

  Future<void> _processQR(String qrData) async {
    try {
      // Separar datos del QR (ejemplo: URL o JSON)
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

      // Verificar el RUT en el backend
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
    // Guardar datos en almacenamiento seguro
    await secureStorage.write(key: 'rut', value: rut);
    await secureStorage.write(key: 'serie', value: serie);
    await secureStorage.write(key: 'verificado', value: verificado);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
