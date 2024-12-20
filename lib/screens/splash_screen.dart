import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'ubicacion_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async {
      bool hasInternet = await _checkInternetConnection();
      if (hasInternet) {
        // Si hay conexión a internet, navega a la siguiente pantalla
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UbicacionScreen()),
        );
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

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error de conexión'),
        content: const Text('No tienes conexión a internet. Verifica tu conexión e inténtalo de nuevo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/certivipx.png',
                  height: 100.h,
                ),
                SizedBox(height: 20.h),
                Lottie.asset(
                  'assets/stationwagon.json',
                  width: 250.w,
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Transfiera su Placa Patente Única con Seguridad',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
