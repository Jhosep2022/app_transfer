import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/conoce_tu_appscreen.dart';
import 'package:transfer_app/screens/modo_prueba_screen.dart';
import 'package:transfer_app/screens/terminos_condiciones_screen.dart';
import 'package:transfer_app/screens/politica_privacidad_screen.dart';

class VerificarPPUScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                              // Reemplazar el ícono con PopupMenuButton
                              PopupMenuButton<String>(
                                icon: Icon(Icons.settings, color: Colors.white),
                                onSelected: (String result) {
                                  switch (result) {
                                    case 'Modo Prueba':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ModoPruebaScreen()),
                                      );
                                      break;
                                    case 'Conoce tu Aplicación':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ConoceTuAppScreen()),
                                      );
                                      break;
                                    case 'Términos y Condiciones':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => TerminosCondicionesScreen()),
                                      );
                                      break;
                                    case 'Políticas de Privacidad':
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PoliticaPrivacidadScreen()),
                                      );
                                      break;
                                  }
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Modo Prueba',
                                    child: Text('Aplicación Modo Prueba'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Conoce tu Aplicación',
                                    child: Text('Conoce tu Aplicación'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Términos y Condiciones',
                                    child: Text('Términos y Condiciones'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Políticas de Privacidad',
                                    child: Text('Políticas de Privacidad'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Prepara Transferencias',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'NUESTRA EMPRESA',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  Text(
                    'Certificación Virtual de Identificación Personal',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'CertiVip SpA',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'NUESTRA MISIÓN',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  Text(
                    'AYUDAR A EVITAR LA COMPRA DE VEHÍCULOS ROBADOS',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  // Imágenes de los vehículos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/certivipx.png',
                        width: 150,
                      ),
                      Image.asset(
                        'assets/certivipx.png',
                        width: 150,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'VERIFIQUE SI LA PPU ESTÁ EN VENTA',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'AB•CD•12',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¡¡ Sólo el propietario la puede poner en venta !!',
                    style: TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Botón Volver
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'VOLVER',
                      style: TextStyle(
                        color: Colors.white, // Texto blanco
                        fontWeight: FontWeight.bold, // Negrita
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.teal, // Color del botón
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
