import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/registro_usuario_screen.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class EscanerCarnetScreen extends StatefulWidget {
  @override
  _EscanerCarnetScreenState createState() => _EscanerCarnetScreenState();
}

class _EscanerCarnetScreenState extends State<EscanerCarnetScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = "";

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Cabecera curvada con el mismo diseño del HomeScreen
          Stack(
            children: [
              ClipPath(
                clipper: InvertedHeaderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Escanea tu Carnet',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),

          // Área de escaneo QR
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(height: 20),

          // Texto para el código escaneado (opcional)
          Text(
            'Código escaneado: $qrText',
            style: TextStyle(fontSize: 14, color: Colors.teal),
          ),
          SizedBox(height: 20),

          // Botón para continuar al registro de usuario
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegistroUsuarioScreen(
                    //clave: widget.clave,
                    //region: selectedRegion!,
                    //comuna: selectedComuna!,
                    clave: "",
                    region: "",
                    comuna: "",
                    ciudad: "",
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(
              'CONTINUAR AL REGISTRO',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code!;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
