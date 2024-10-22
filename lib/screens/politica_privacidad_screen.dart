import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

class PoliticaPrivacidadScreen extends StatelessWidget {
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
                    height: MediaQuery.of(context).size.height * 0.22,
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
                            'POLÍTICA DE PRIVACIDAD',
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
                    'CertiVip SpA, informa sobre la Política de Privacidad, a los usuarios de la aplicación “Administración del Estado de la Placa Patente Única”, AEEPU por su sigla en español, acerca del tratamiento de los datos personales, que ellos voluntariamente hayan facilitado durante el proceso de registro, acceso y utilización de la App.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'La App AEEPU no es ni representa a ninguna institución gubernamental, sin embargo, utiliza datos de estas, que son de uso público y de pagos, los cuales CertiVip SpA no modifica ni altera, sólo los usa, por lo tanto, no tiene responsabilidad si parte o la totalidad de estos, no son fidedignos.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '1. IDENTIFICACIÓN DEL RESPONSABLE DEL TRATAMIENTO DE DATOS PERSONALES',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'CertiVip SpA, es responsable del tratamiento de los datos facilitados voluntariamente por los clientes de la App.',
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
