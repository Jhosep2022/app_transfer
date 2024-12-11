import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:transfer_app/services/revision_tecnica_service.dart';

class RevisionTecnicaScreen extends StatefulWidget {
  @override
  _RevisionTecnicaScreenState createState() => _RevisionTecnicaScreenState();
}

class _RevisionTecnicaScreenState extends State<RevisionTecnicaScreen> {
  final TextEditingController _ppuController = TextEditingController();
  final RevisionTecnicaService _service = RevisionTecnicaService();
  String? _htmlContent;
  String? _error;
  bool _isLoading = false;

  void _consultarDatosRevisionTecnica() async {
  final ppu = _ppuController.text.trim();
  if (ppu.isEmpty || ppu.length != 6) {
    setState(() {
      _error = 'Ingrese una PPU válida (6 caracteres).';
      _htmlContent = null;
      _isLoading = false;
    });
    return;
  }

  setState(() {
    _error = null;
    _htmlContent = null;
    _isLoading = true;
  });

  try {
    final html = await _service.fetchHtml(ppu);

    // Agregar la etiqueta <base> al HTML
    final baseUrl = 'https://www.prt.cl/';
    final modifiedHtml = '''
      <!DOCTYPE html>
      <html>
      <head>
        <base href="$baseUrl">
      </head>
      <body>
        $html
      </body>
      </html>
    ''';

    setState(() {
      _htmlContent = modifiedHtml;
      _isLoading = false;
    });
  } catch (e) {
    setState(() {
      _error = 'Error al obtener los datos: $e';
      _htmlContent = null;
      _isLoading = false;
    });
  }
}


  Widget _buildDatosRevisionTecnica() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Text(
        _error!,
        style: TextStyle(color: Colors.red),
      );
    }

    if (_htmlContent == null) {
      return Text('Ingrese una PPU y presione "Consultar" para ver los datos.');
    }

    return Container(
      height: 400, // Ajusta según sea necesario
      child: InAppWebView(
        initialData: InAppWebViewInitialData(data: _htmlContent!),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ppuController,
                          maxLength: 6,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: 'PPU',
                            border: UnderlineInputBorder(),
                            counterText: '',
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _consultarDatosRevisionTecnica,
                        child: Text(
                          'CONSULTAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildDatosRevisionTecnica(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'VOLVER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
