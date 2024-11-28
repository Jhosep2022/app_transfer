import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../services/vehiculos_service.dart';
import 'crear_clave_ingreso_screen.dart';

class CedulaScannerScreen extends StatefulWidget {
  @override
  _CedulaScannerScreenState createState() => _CedulaScannerScreenState();
}

class _CedulaScannerScreenState extends State<CedulaScannerScreen> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "";
  String resultMessage = "";

  final VehiculosService _vehiculosService = VehiculosService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Agrega el observer del ciclo de vida
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Elimina el observer
    controller?.dispose(); // Libera los recursos de la cámara
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller != null) {
      if (state == AppLifecycleState.paused) {
        controller!.pauseCamera(); // Pausa la cámara si la app está en segundo plano
      } else if (state == AppLifecycleState.resumed) {
        controller!.resumeCamera(); // Reanuda la cámara si la app vuelve a estar activa
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
                        color: resultMessage.contains('RUT Verificado') ? Colors.green : Colors.red,
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
      _validateRut(qrText);
    });
  }

  Future<void> _validateRut(String rut) async {
    try {
      final result = await _vehiculosService.verificaRut(rut);
      if (result != null) {
        setState(() {
          resultMessage = result['activo'] == 'true'
              ? 'RUT Verificado: Activo'
              : 'RUT No Activo';
        });
      } else {
        setState(() {
          resultMessage = 'RUT no encontrado.';
        });
      }
    } catch (e) {
      setState(() {
        resultMessage = 'Error al verificar el RUT.';
      });
    } finally {
      controller?.resumeCamera(); // Reanuda la cámara después del proceso
    }
  }
}
