import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transfer_app/screens/home_screen.dart';

class IdentificacionDuenoScreen extends StatefulWidget {
  @override
  _IdentificacionDuenoScreenState createState() => _IdentificacionDuenoScreenState();
}

class _IdentificacionDuenoScreenState extends State<IdentificacionDuenoScreen> {
  // Variables para almacenar los datos cargados
  String rut = '';
  String apellidoPaterno = '';
  String apellidoMaterno = '';
  String nombres = '';
  String telefono = '';
  String direccion = '';
  String razonSocial = '';
  String giro = '';
  String correo = '';
  String vin = '';
  String nroMotor = '';
  String idChasis = '';
  String tipo = '';
  String anio = '';
  String marca = '';
  String modelo = '';
  String color = '';
  String patente = '';
  String ciudad = '';
  String comuna = '';
  String impuesto = '';
  String valorBase = '';

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences(); // Cargar datos al iniciar la pantalla
  }

  Future<void> _loadSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Datos comprador
      rut = prefs.getString('rut') ?? 'No disponible';
      apellidoPaterno = prefs.getString('apellidoPaterno') ?? 'No disponible';
      apellidoMaterno = prefs.getString('apellidoMaterno') ?? 'No disponible';
      nombres = prefs.getString('nombres') ?? 'No disponible';
      telefono = prefs.getString('telefono') ?? 'No disponible';
      direccion = prefs.getString('direccion') ?? 'No disponible';
      razonSocial = prefs.getString('razonSocial') ?? 'No disponible';
      giro = prefs.getString('giro') ?? 'No disponible';
      correo = prefs.getString('correo_usuario') ?? 'No disponible';

      // Datos vehículo
      vin = prefs.getString('vin') ?? 'No disponible';
      nroMotor = prefs.getString('nro_motor') ?? 'No disponible';
      idChasis = prefs.getString('chasis') ?? 'No disponible';
      tipo = prefs.getString('tipo_automovil') ?? 'No disponible';
      anio = prefs.getString('anio_automovil') ?? 'No disponible';
      marca = prefs.getString('marca_automovil') ?? 'No disponible';
      modelo = prefs.getString('modelo') ?? 'No disponible';
      color = prefs.getString('color') ?? 'No disponible';
      patente = prefs.getString('patente_compra') ?? 'No disponible';
      impuesto = prefs.getString('impuesto') ?? 'No disponible';
      valorBase = prefs.getString('valor_base') ?? 'No disponible';

      // Región
      ciudad = prefs.getString('ciudad') ?? 'No disponible';
      comuna = prefs.getString('comuna') ?? 'No disponible';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IDENTIFICACION DUEÑO(A)'),
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
                title: 'IDENTIFICACION DUEÑO(A)',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rut,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(razonSocial),
                    Text(direccion),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ciudad),
                        Text(comuna),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(correo),
                        Text(telefono),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(giro),
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
                          patente,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    _buildKeyValueRow('VIN', vin),
                    _buildKeyValueRow('NRO MOTOR', nroMotor),
                    _buildKeyValueRow('ID CHASIS', idChasis),
                    _buildKeyValueRow('Tipo', tipo),
                    _buildKeyValueRow('Año', anio),
                    _buildKeyValueRow('Marca', marca),
                    _buildKeyValueRow('Modelo', modelo),
                    _buildKeyValueRow('Color', color),
                    _buildKeyValueRow('Precio Base', valorBase),
                    _buildKeyValueRow('Impuesto', impuesto),
                  ],
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
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
