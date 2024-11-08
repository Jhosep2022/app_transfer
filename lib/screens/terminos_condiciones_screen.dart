import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

class TerminosCondicionesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                            'Términos y Condiciones',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Estos Términos y Condiciones que establece CERTIVIP SPA es para la “Administración del Estado de la Placa Patente Única” AEEPU, por su sigla en español.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Estos Términos de Condiciones regulan la utilización de la App AEEPU en CHILE, que tiene por finalidad principal la de Preparar una Transferencia Electrónica de Vehículos PRETAV, por su sigla en español.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nuestra App AEEPU no es gubernamental, ni representa a una institución gubernamental, sin embargo, utiliza datos de uso público, los cuales se pueden descargar en forma gratuita desde el Ministerio de Transportes y Telecomunicaciones a través de su página web:',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Implementa el redireccionamiento a la web aquí
                      print('Redirigir a la web');
                    },
                    child: Text(
                      'https://www.prt.cl/Descargas/index.html',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Los datos que extraemos en formato Excel (comprimido) desde dicha página web, entre otros son: Placa Patente Única (PPU), Marca, ...',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  // Botón Volver
                  Center(
                    child: ElevatedButton(
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
