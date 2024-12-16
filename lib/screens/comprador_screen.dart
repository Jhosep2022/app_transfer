import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/datos_legales_comprador_screen.dart';
import 'package:transfer_app/screens/impuesto_municipal_screen.dart';
import 'package:transfer_app/screens/placa_denegada_screen.dart';
import 'package:transfer_app/services/vehiculos_service.dart'; // Importamos la pantalla de "Placa Denegada"

class CompradorScreen extends StatefulWidget {
  @override
  _CompradorScreenState createState() => _CompradorScreenState();
}

class _CompradorScreenState extends State<CompradorScreen> {
  TextEditingController _ppuController = TextEditingController();
  TextEditingController _chasisCivilController = TextEditingController();
  TextEditingController _chasisCivilRepeatController = TextEditingController();

  bool _isSearched = false; // Controla si se ha realizado la búsqueda
  String? _selectedRegion; // Almacena la región seleccionada
  final VehiculosService _vehiculosService = VehiculosService();

  // Variables simuladas para mostrar después de la búsqueda
  String tipo = '';
  String anio = '';
  String marca = '';
  String modelo = '';
  String vendeAutomovil = '';
  String robadoAutomovil = '';
  String perdidoAutomovil = '';
  String region = '';

  String patenteCivil = '';
  String digitoCivil = '';
  String nombreCivil = '';
  String vinCivil = '';
  String chasisCivil = '';
  String serieCivil = '';
  String motorCivil = '';
  String rutCivil = '';
  String tipoCivil = '';
  String anuCivil = '';
  String modeloCivil = '';
  String marcaCivil = '';
  String colorCivil = '';

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
                  _buildTextField(labelText: 'ID CHASIS', hintText: 'Nro. Chasis directo del Vehículo', controller: _chasisCivilController),
                  SizedBox(height: 16),
                  // Campo para repetir Nro. Chasis
                  _buildTextField(labelText: 'REPITE NRO.', hintText: 'Repite Nro de Chasis', controller: _chasisCivilRepeatController),
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
          onPressed: () async {
            final vehiculosService = VehiculosService();
            final patente = _ppuController.text;

                              if (patente.isEmpty || patente.length < 6) {
                                // Mostrar un mensaje de error si la patente es inválida
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Por favor, ingresa una patente válida.')),
                                );
                                return;
                              }

                              // Llamar al servicio y obtener los datos del vehículo
                              final vehiculo = await vehiculosService.consultarRegistroInterno(patente);
                              final consultaVechiculo = await vehiculosService.consultarRegistroCivil(patente);
                              
                              if (vehiculo != null && consultaVechiculo != null) {
                                // Imprimir la respuesta en consola
                                setState(() {
                                  tipo = vehiculo.tipo;
                                  modelo = vehiculo.modelo;
                                  anio = vehiculo.ano;
                                  marca = vehiculo.marca;
                                  vendeAutomovil = vehiculo.estadoVenta;
                                  robadoAutomovil = vehiculo.estadoRobo;
                                  perdidoAutomovil = vehiculo.estadoPerdida;
                                  region = vehiculo.region;
                                
                                  patenteCivil = consultaVechiculo.patenteCivil;
                                  digitoCivil = consultaVechiculo.digitoCivil;
                                  nombreCivil = consultaVechiculo.nombreCivil;
                                  vinCivil = consultaVechiculo.vinCivil;
                                  chasisCivil = consultaVechiculo.chasisCivil;
                                  serieCivil = consultaVechiculo.serieCivil;
                                  motorCivil = consultaVechiculo.motorCivil;
                                  rutCivil = consultaVechiculo.rutCivil;
                                  tipoCivil = consultaVechiculo.tipoCivil;
                                  anuCivil = consultaVechiculo.anuCivil;
                                  marcaCivil = consultaVechiculo.marcaCivil;
                                  modeloCivil = consultaVechiculo.modeloCivil;
                                  colorCivil = consultaVechiculo.colorCivil;
                                });
                                print('Vehículo encontrado: ${vehiculo.toJson()}');

                                // Opcional: mostrar los datos en pantalla
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Vehículo encontrado')),
                                );
                              } else {
                                // Si no se encuentra el vehículo
                                setState(() {
                                  tipo = "No encontrado";
                                  modelo = "Sin Modelo";
                                  anio = "Sin año";
                                  marca = "Sin marca";
                                  vendeAutomovil = "Sin información";
                                  robadoAutomovil = "Sin información";
                                  perdidoAutomovil = "Sin información";
                                  region = "Sin región";

                                  patenteCivil = "Sin patente";
                                  digitoCivil = "Sin dígito";
                                  nombreCivil = "Sin nombre";
                                  vinCivil = "Sin VIN";
                                  chasisCivil = "Sin chasis";
                                  serieCivil = "Sin serie";
                                  rutCivil = "Sin rut";
                                  motorCivil = "Sin motor";
                                  tipoCivil = "Sin tipo";
                                  anuCivil = "Sin año";
                                  marcaCivil = "Sin marca";
                                  modeloCivil = "Sin modelo";
                                  colorCivil = "Sin color";
                                });
                                print('No se encontró información para la patente ingresada.');

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('No se encontró información para la patente ingresada.')),
                                );
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

  Widget _buildTextField({required String labelText, required String hintText, required TextEditingController controller}) {
    return TextField(
      controller: controller,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tipo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(tipo, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Año:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(anio, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Marca:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(marca, style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Modelo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(modelo, style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        if(robadoAutomovil == "Sí"){
          buildDialog(context, 'Vehículo Robado', 'El vehículo que intenta comprar se encuentra en la lista de vehículos robados. Por favor, contacte a las autoridades.');
        }
        if(perdidoAutomovil == "Sí"){
          buildDialog(context, 'Vehículo Perdido', 'El vehículo que intenta comprar se encuentra en la lista de vehículos perdidos. Por favor, contacte a las autoridades.'); 
        }
        if(vendeAutomovil == "Sí"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DatosLegalesCompradorScreen()),
            );
        }
        if(_chasisCivilController != _chasisCivilRepeatController && chasisCivil != _chasisCivilRepeatController.text){
          buildDialog(context, 'Chasis Incorrecto', 'El número de chasis ingresado no coincide. Por favor, verifique los datos ingresados.');
        }
        if(vendeAutomovil == "No"){
          buildDialog(context, 'Vehículo no esta en Venta', 'El vehículo que intenta comprar se encuentra en la lista de vehículos no esta en venta.');          
        }
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

  void buildDialog(BuildContext context, String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

}
