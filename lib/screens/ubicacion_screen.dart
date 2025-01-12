import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/home_screen.dart';
import 'package:transfer_app/screens/transferencia_ppu_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UbicacionScreen extends StatefulWidget {
  @override
  _UbicacionScreenState createState() => _UbicacionScreenState();
}

class _UbicacionScreenState extends State<UbicacionScreen> {
  String numeroSerie = "";
  String rut = "";
  String tipo = "";
  String latitud = "";
  String longitud = "";
  String sesion = "";

  // Método para cargar datos desde SharedPreferences
  Future<void> _cargarDatosSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      numeroSerie = prefs.getString('serial') ?? "";
      rut = prefs.getString('rut') ?? "";
      tipo = prefs.getString('tipo') ?? "";
      latitud = prefs.getString('latitud') ?? "";
      longitud = prefs.getString('longitud') ?? "";
      sesion = prefs.getString('inicio_sesion') ?? "cerrado";
    });
  }

  Future<void> _saveToLatLong(double longitud, double latitud ) async {
    // Guardar los datos en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('longitud', longitud.toString());
    await prefs.setString('latitud', latitud.toString());
  }

  bool _isLoading = true;
  String _locationMessage = "Estamos buscando tu ubicación...";
  Position? _currentPosition;
  LatLng? _currentLatLng;
  final MapController _mapController = MapController();
  bool _isMapRendered = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndLocate();
    _cargarDatosSharedPreferences();
  }

  Future<void> _checkPermissionsAndLocate() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      _getCurrentLocation();
    } else {
      setState(() {
        _locationMessage = "Permiso de ubicación denegado.";
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Los servicios de ubicación están desactivados.";
        _isLoading = false;
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _currentLatLng = LatLng(position.latitude, position.longitude);
      _locationMessage = "Ubicación actual:\nLatitud: ${position.latitude}\nLongitud: ${position.longitude}";
      _isLoading = false;
      _moveToCurrentLocation();
      _saveToLatLong(position.longitude, position.latitude);
    });

    // Espera de 2 segundos antes de redirigir
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _isMapRendered) {
        if(sesion == "iniciado"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TransferenciaPPUScreen()),
          );
        }
      }
    });
  }

  void _moveToCurrentLocation() {
    if (_isMapRendered && _mapController != null && _currentLatLng != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        _mapController.move(_currentLatLng!, 15.0); // Mueve el mapa a la ubicación actual con zoom
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera curvada similar a HomeScreen
          Stack(
            children: [
              ClipPath(
                clipper: InvertedHeaderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.23*0.75,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0*0.75),
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
                        SizedBox(height: 20*0.75),
                        Text(
                          'UBICACIÓN',
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
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text(
                          _locationMessage,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentLatLng ?? const LatLng(0, 0),
                      initialZoom: 15.0,
                      onMapReady: () {
                        setState(() {
                          _isMapRendered = true;
                        });
                        _moveToCurrentLocation();
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      if (_currentLatLng != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _currentLatLng!,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
