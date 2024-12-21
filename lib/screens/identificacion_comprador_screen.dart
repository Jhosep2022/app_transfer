import 'package:flutter/material.dart';

class IdentificacionCompradorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IDENTIFICACION COMPRADOR(A)'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSection(
                title: 'IDENTIFICACION COMPRADOR(A)',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '77662706-2',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('CERTIFICACION VIRTUAL DE IDENTIFICACION PERSONAL SPA'),
                    Text('ARTURO PRAT 831 SAN CARLOS'),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Chillán'),
                        Text('San Carlos'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('miguelfuicaj@gmail.com'),
                        Text('56'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('gh'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              _buildSection(
                title: 'IDENTIFICACION DEL VEHICULO',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'PATENTE: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'ZZZZ66-6',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    _buildKeyValueRow('VIN', 'VIN'),
                    _buildKeyValueRow('NRO MOTOR', 'NROMOTOR'),
                    _buildKeyValueRow('ID CHASIS', 'CHASIS'),
                    _buildKeyValueRow('Tipo', 'AUTOMOVIL'),
                    _buildKeyValueRow('Año', '2018'),
                    _buildKeyValueRow('Marca', 'PEUGEOT'),
                    _buildKeyValueRow('Modelo', '308 BLUE HDI HB 1.6 AUT'),
                    _buildKeyValueRow('Color', 'COLOR'),
                  ],
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'VOLVER AL PRINCIPIO',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.greenAccent.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              key + ':',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
