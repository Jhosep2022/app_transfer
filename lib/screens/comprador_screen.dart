import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/datos_legales_comprador_screen.dart';
import 'package:transfer_app/screens/placa_denegada_screen.dart'; // Importamos la pantalla de "Placa Denegada"

class CompradorScreen extends StatefulWidget {
  @override
  _CompradorScreenState createState() => _CompradorScreenState();
}

class _CompradorScreenState extends State<CompradorScreen> {
  TextEditingController _ppuController = TextEditingController();
  bool _isSearched = false; // Controla si se ha realizado la búsqueda
  String? _selectedRegion; // Almacena la región seleccionada

  // Variables simuladas para mostrar después de la búsqueda
  String tipo = '';
  String anio = '';
  String marca = '';
  String modelo = '';

  // Lista de regiones de Chile
  final List<String> regiones = [
    'Tarapacá',
    'Antofagasta',
    'Atacama',
    'Coquimbo',
    'Valparaíso',
    'O’Higgins',
    'Maule',
    'Biobío',
    'La Araucanía',
    'Los Lagos',
    'Aysén',
    'Magallanes',
    'Metropolitana',
    'Los Ríos',
    'Arica y Parinacota',
    'Ñuble',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  // DropdownButton para seleccionar región
                  _buildDropdownButton(),
                  SizedBox(height: 20),
                  // Campo de entrada de P.P.U. (Forzado a mayúsculas, limitado a 6 caracteres)
                  _buildPpuField(),
                  SizedBox(height: 20),
                  // Campo de ID Chasis
                  _buildTextField(labelText: 'ID CHASIS', hintText: 'Nro. Chasis directo del Vehículo'),
                  SizedBox(height: 16),
                  // Campo para repetir Nro. Chasis
                  _buildTextField(labelText: 'REPITE NRO.', hintText: 'Repite Nro de Chasis'),
                  SizedBox(height: 20),
                  // Sección de detalles: Tipo, Año, Marca, Modelo
                  _buildCarDetails(),
                  SizedBox(height: 20),
                  // Botón Continuar
                  _buildContinueButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
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
                    'COMPRADOR(A)',
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
    );
  }

  Widget _buildDropdownButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonFormField<String>(
        value: _selectedRegion,
        hint: Text(
          'Pulsa y Elige región donde estás',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        items: regiones.map((String region) {
          return DropdownMenuItem<String>(
            value: region,
            child: Text(region),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedRegion = newValue;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        isExpanded: false, // Limitar el ancho del Dropdown
        dropdownColor: Colors.white, // Color del Dropdown
        elevation: 5, // Sombra del Dropdown
        icon: Icon(Icons.arrow_drop_down), // Ícono para abrir el Dropdown
      ),
    );
  }

  Widget _buildPpuField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _ppuController,
            maxLength: 6, // Limitar a 6 dígitos
            textCapitalization: TextCapitalization.characters, // Fuerza mayúsculas
            decoration: InputDecoration(
              labelText: 'P.P.U.',
              border: UnderlineInputBorder(),
              counterText: '', // Ocultar el contador de caracteres
            ),
            onChanged: (value) {
              setState(() {
                _ppuController.value = _ppuController.value.copyWith(
                  text: value.toUpperCase(),
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: _ppuController.text.length),
                  ),
                );
              });
            },
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            if (_ppuController.text.length < 6) {
              // Si tiene menos de 6 dígitos, redirige a la pantalla "Placa Denegada"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlacaDenegadaScreen()),
              );
            } else {
              // Simula la búsqueda y llena los datos si la PPU tiene 6 dígitos
              setState(() {
                tipo = 'SUV';
                anio = '2020';
                marca = 'Toyota';
                modelo = 'Highlander';
                _isSearched = true;
              });
            }
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
            backgroundColor: Colors.teal,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({required String labelText, required String hintText}) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCarDetails() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tipo: $tipo', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Año: $anio', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Marca: $marca', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Modelo: $modelo', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DatosLegalesCompradorScreen()),
        );
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
    );
  }
}
