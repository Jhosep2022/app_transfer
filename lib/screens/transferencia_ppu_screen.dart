import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/comprador_screen.dart';
import 'package:transfer_app/screens/crear_clave_ingreso_screen.dart';
import 'package:transfer_app/screens/instituciones_estado_screen.dart';
import 'package:transfer_app/screens/propietario_screen.dart';
import 'package:transfer_app/screens/terminos_condiciones_screen.dart';
import 'package:transfer_app/screens/politica_privacidad_screen.dart';
import 'package:transfer_app/screens/cedula_scanner_screen.dart'; // Pantalla de escaneo de cédula
import 'package:transfer_app/screens/e_rut_scanner_screen.dart';

import 'identificacion_comprador_screen.dart';
import 'identificacion_dueno_screen.dart'; // Pantalla de escaneo de e-rut

class TransferenciaPPUScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con gradiente de color
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal.shade100,
                  Colors.teal.shade800,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  Icon(Icons.arrow_back, color: Colors.white),
                                  Icon(Icons.settings, color: Colors.white),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Preparando',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Transferencia de PPU',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Para comenzar escanee QR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      _buildButton(context, 'CÉDULA IDENTIDAD', CedulaScannerScreen()),
                      SizedBox(height: 16),
                      _buildButton(context, 'E-RUT', ERutScannerScreen()),
                      SizedBox(height: 30),
                      _buildTextButton(context, 'TÉRMINOS Y CONDICIONES'),
                      SizedBox(height: 8),
                      _buildTextButton(context, 'POLÍTICA DE PRIVACIDAD'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Widget screen) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTextButton(BuildContext context, String text) {
    return TextButton(
      onPressed: () {
        if (text == 'TÉRMINOS Y CONDICIONES') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TerminosCondicionesScreen()),
          );
        } else if (text == 'POLÍTICA DE PRIVACIDAD') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PoliticaPrivacidadScreen()),
          );
        }
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
