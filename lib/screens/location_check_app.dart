import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationCheckApp extends StatefulWidget {
  @override
  _LocationCheckAppState createState() => _LocationCheckAppState();
}

class _LocationCheckAppState extends State<LocationCheckApp> {
  @override
  void initState() {
    super.initState();
    _checkLocationService();
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationAlert();
    } else {
      // Opcional: Solicita permisos si no están otorgados.
      await _checkLocationPermission();
    }
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  void _showLocationAlert() {
    showDialog(
      context: context,
      barrierDismissible: false, // El usuario no puede cerrar la alerta.
      builder: (context) {
        return AlertDialog(
          title: Text("Ubicación Desactivada"),
          content: Text(
              "Debes activar la ubicación para continuar usando la aplicación."),
          actions: [
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                _checkLocationService(); // Verifica nuevamente al volver.
              },
              child: Text("Abrir Configuración"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Verificar Ubicación')),
        body: Center(
          child: Text('Ubicación activa.'),
        ),
      ),
    );
  }
}
