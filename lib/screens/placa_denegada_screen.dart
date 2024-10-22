import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/home_screen.dart';

class PlacaDenegadaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cabecera curvada
          Stack(
            children: [
              ClipPath(
          clipper: InvertedHeaderClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Regresar a la pantalla anterior
              },
            ),
            SizedBox(width: 10),
            Text(
              'ACCESO DENEGADO',
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

          SizedBox(height: 30),

          // Información de texto
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Text(
                  'ENTRE COMO COMPRADOR(A)',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Esta Placa Patente Única',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                SizedBox(height: 10),
                Text(
                  '¡No le pertenece!',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Spacer(),

          // Botón "Continuar"
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                backgroundColor: Colors.teal,
              ),
              child: Text(
                'CONTINUAR',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
