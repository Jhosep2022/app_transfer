import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

class PlacaDenegadaCompradorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cabecera curvada
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
                            'ENTRE COMO PROPIETARIA(O)',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Esta Placa Patente Única',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Está a su nombre',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Botón "Continuar"
                  ElevatedButton(
                    onPressed: () {
                      // Acción al presionar "Continuar"
                    },
                    child: Text(
                      'CONTINUAR',
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
