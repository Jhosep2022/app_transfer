import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/clave_screen.dart';
import 'package:transfer_app/screens/comprador_screen.dart';
import 'package:transfer_app/screens/instituciones_estado_screen.dart';
import 'package:transfer_app/screens/transferencia_ppu_screen.dart';
import 'package:transfer_app/screens/verificar_ppu_screen.dart';

import 'mi_ubicacion_home_screen.dart'; // Importa tu pantalla de InstitucionesEstadoScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                                GestureDetector(
                                onTap: () {
                                  showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                    title: Text('Cerrar sesión'),
                                    content: Text('¿Estás seguro de que deseas cerrar sesión?'),
                                    actions: [
                                      TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      ),
                                        TextButton(
                                        child: Text('Aceptar'),
                                        onPressed: () async {
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          await prefs.setString('rut', "No disponible");
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => TransferenciaPPUScreen()),
                                        );
                                        },
                                        ),
                                    ],
                                    );
                                  },
                                  );
                                },
                                child: Icon(Icons.logout, color: Colors.white),
                                ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Hola Andre,',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your available balance',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bienvenido !',
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(context, 'Propietario', Icons.person),
                      _buildActionButton(context, 'Comprador', Icons.shopping_cart),
                      _buildActionButton(context, 'Mi ubicacion', Icons.location_on),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Consultas',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Redirigir a la pantalla de InstitucionesEstadoScreen al hacer clic en "Ver Más"
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VerificarPPUScreen()),
                          );
                        },
                        child: Text(
                          'Ver Mas',
                          style: TextStyle(color: Colors.teal, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Redirigir a la pantalla de InstitucionesEstadoScreen al hacer clic en la tarjeta de promoción
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InstitucionesEstadoScreen()),
                      );
                    },
                    child: _buildPromoCard(), // Tarjeta de promoción
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para los botones de acción
  Widget _buildActionButton(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == 'Propietario') {
          // Navegar a ClaveScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClaveScreen()),
          );
        }
        if (title == 'Comprador') {
          // Navegar a CompradorScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CompradorScreen()),
          );
        }
        if (title == 'Mi ubicacion') {
          // Navegar a CompradorScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MiUbicacionHomeScreen()),
          );
        }        
        // Puedes agregar más pantallas según el título
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }

  // Widget para la tarjeta de promoción
  Widget _buildPromoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.question_answer, color: Colors.teal, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consultas en instituciones del estado',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Accede a información y servicios de manera rápida y sencilla.',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
