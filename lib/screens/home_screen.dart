import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Necesario para verificar conexión
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/clave_screen.dart';
import 'package:transfer_app/screens/comprador_screen.dart';
import 'package:transfer_app/screens/instituciones_estado_screen.dart';
import 'package:transfer_app/screens/splash_screen.dart';
import 'package:transfer_app/screens/transferencia_ppu_screen.dart';
import 'package:transfer_app/screens/verificar_ppu_screen.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location_service.dart';
import 'mi_ubicacion_home_screen.dart';
import 'ubicacion_screen.dart'; // Pantalla de destino para Ubicación

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String alias = ""; // Variable para almacenar el alias
  final LocationService _locationService = LocationService();
  late StreamSubscription<bool> _locationSubscription;

  Future<void> _cargarCorreoUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      alias = prefs.getString('alias') ?? "No disponible";
    });
  }

  @override
  void initState() {
    super.initState();
    _locationSubscription =
        _locationService.locationStream.listen((isLocationEnabled) {
      if (!isLocationEnabled) {
        _showLocationAlert();
      }
    });

    Timer(Duration(seconds: 5), () async {
      bool hasInternet = await _checkInternetConnection();
      if (hasInternet) {
      } else {
        // Si no hay conexión, muestra un alert
        _showNoInternetDialog();
      }
    });
  }

  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false; // Sin conexión
    }
    return true; // Con conexión
  }

  void _showLocationAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Ubicación Desactivada"),
        content: Text(
            "Debes activar la ubicación para continuar usando la aplicación."),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Cierra la alerta.
              await Geolocator.openLocationSettings();
            },
            child: Text("Abrir Configuración"),
          ),
        ],
      ),
    );
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error de conexión'),
        content: const Text(
            'No tienes conexión a internet. Verifica tu conexión e inténtalo de nuevo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Si hay conexión a internet, navega a la siguiente pantalla
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SplashScreen()),
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _locationSubscription.cancel();
    _locationService.dispose();
    super.dispose();
  }

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
                                        content: Text(
                                            '¿Estás seguro de que deseas cerrar sesión?'),
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
                                              SharedPreferences prefs =
                                                  await SharedPreferences.getInstance();
                                              await prefs.setString('rut', "No disponible");
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TransferenciaPPUScreen()),
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
                            'Hola $alias',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InstitucionesEstadoScreen()),
                      );
                    },
                    child: _buildPromoCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == 'Propietario') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClaveScreen()),
          );
        }
        if (title == 'Comprador') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CompradorScreen()),
          );
        }
        if (title == 'Mi ubicacion') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MiUbicacionHomeScreen()),
          );
        }
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
