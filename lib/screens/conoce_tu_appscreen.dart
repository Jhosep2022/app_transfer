import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

class ConoceTuAppScreen extends StatelessWidget {
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
                            'FAMILIARIZATE CON TU APP',
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
                    'INTRODUCCIÓN',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'El propósito de esta App es que, tanto "El Propietario(a)" como "El Comprador(a)" puedan Preparar la Transferencia de una PPU (Vehículo) con datos directos de una Institución del Estado.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Esta Preparación es para saber qué información provee respecto de los datos que van en un contrato de compra/venta en una transferencia de un vehículo, sin que, por el momento realicemos la Transferencia propiamente tal.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'El propietario «Administra del Estado de la Placa Patente Única, AEEPU por su sigla en español, es decir, puede manipular (la propia) o/e Informarse de la situación de cada Placa Patente Única (PPU) de vehículos usados de dos o más ruedas.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nuestra App, permite detectar la duplicación (Clonación) de la Placa Patente Única, basado en que, a un vehículo se le puede instalar cualquier PPU, propio, no necesariamente el Propietario(a), tiene su vehículo en venta en nuestra App, es decir, en venta la PPU.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Para Preparar la Transferencia de un Vehículo, siempre nos referimos a la PPU, porque es lo que les interesa a todos: Servicio del Registro Civil, Propietario(a), Notaría, etc. Además, de evitar fraudes por clonación.',
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
