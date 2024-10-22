import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

class RevisionTecnicaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera curvada como en PropietarioScreen
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
                            'REVISIÓN TÉCNICA',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPpuField(), // Campo de entrada de P.P.U. y botón "Consultar"
                  SizedBox(height: 20),
                  _buildRecaptcha(), // Componente simulado del reCAPTCHA
                  SizedBox(height: 20),
                  _buildDatosRevisionTecnica(), // Tabla con los datos de revisión técnica
                  SizedBox(height: 20),
                  _buildVolverButton(context), // Botón "Volver"
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Campo de entrada de P.P.U. y botón "Consultar"
  Widget _buildPpuField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLength: 6, // Limitar a 6 caracteres
            textCapitalization: TextCapitalization.characters, // Forzar mayúsculas
            decoration: InputDecoration(
              labelText: 'PPU',
              border: UnderlineInputBorder(),
              counterText: '', // Ocultar el contador de caracteres
            ),
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            // Acción al presionar "Consultar"
          },
          child: Text(
            'CONSULTAR',
            style: TextStyle(
              color: Colors.white, // Texto blanco
              fontWeight: FontWeight.bold, // Negrita
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.teal, // Color del botón
          ),
        ),
      ],
    );
  }

  // Simulación del reCAPTCHA
  Widget _buildRecaptcha() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('No soy un robot'),
          value: false, // Simulación, no funcional
          onChanged: (bool? value) {},
          controlAffinity: ListTileControlAffinity.leading,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Enviar'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.grey[300], // Fondo gris claro
          ),
        ),
      ],
    );
  }

  // Sección de datos de la revisión técnica
  Widget _buildDatosRevisionTecnica() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Datos Revisión Técnica',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _buildDataRow('PLACA PATENTE:', 'BBBB22'),
        _buildDataRow('Marca:', 'TOYOTA'),
        _buildDataRow('Tipo:', 'AUTOMOVIL'),
        _buildDataRow('Modelo:', 'YARIS XLI 1.5'),
        _buildDataRow('Año Fab.:', '2008'),
        _buildDataRow('Tipo Sello:', 'SELLO VERDE'),
        _buildDataRow('Región:', 'VI del Libertador B. O’Higgins'),
        _buildDataRow('Nº Cert:', 'B061100000185990'),
      ],
    );
  }

  // Filas de los datos de revisión técnica
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  // Botón "Volver"
  Widget _buildVolverButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'VOLVER',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold, // Texto en negrita
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.teal, // Color del botón
      ),
    );
  }
}
