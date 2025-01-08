import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PoliticaPrivacidadScreen extends StatefulWidget {
  @override
  _PoliticaPrivacidadScreenState createState() => _PoliticaPrivacidadScreenState();
}

class _PoliticaPrivacidadScreenState extends State<PoliticaPrivacidadScreen> {
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera curvada reutilizada
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Icon(Icons.settings, color: Colors.white),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'POLÍTICA DE PRIVACIDAD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(Uri.parse("https://certivip.com/politica-de-privacidad/")),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
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
            ),
          ),
        ],
      ),
    );
  }
}
