import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

class ModoPruebaScreen extends StatelessWidget {
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
                            'APLICACIÓN EN MODO PRUEBA',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Usa las Placa Patente Única ficticias (ZZZZ??) como se indica más abajo, para que conozcas el resultado que obtendrás cuando utilices la App con una real, tuya, o de un tercero. (Desliza el texto para llegar al final). Después de terminar de leer, sale de la App, bórrala de pantalla y vuelve a entrar.',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No almacenamos datos personales, excepto Rut, correo electrónico y coordenadas geográficas. Es importante destacar que los puedes eliminar con errar varias veces la clave de la App. (Queda lista para volver a instalarla).',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'El propósito de esta App es que, tanto "El Propietario(a)" como "El Comprador(a)" puedan Preparar la Transferencia de una Placa Patente Única (PPU) (Vehículo).',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Preparar una Transferencia, no es sólo conocer los datos que deben ir en un contrato de compra/venta al realizar una Transferencia, sino que también si todos están correctos. El App te mostrará los datos que se encuentran en el Registro de Vehículos Motorizados del Registro Civil.',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  // Botón Continuar
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
