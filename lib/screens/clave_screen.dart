import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/propietario_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; 

class ClaveScreen extends StatelessWidget {
  Future<String?> _obtenerClaveLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('clave_local'); // Obtener la clave almacenada
  }

  void _verificarClave(BuildContext context, String claveIngresada) async {
    String? claveLocal = await _obtenerClaveLocal();
    if (claveLocal == null) {
      _mostrarDialogo(context, 'Error', 'No hay clave configurada en la aplicación.');
    } else if (claveIngresada == claveLocal) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PropietarioScreen()),
      );
    } else {
      _mostrarDialogo(context, 'Clave incorrecta', 'La clave ingresada no coincide.');
    }
  }

  void _mostrarDialogo(BuildContext context, String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String claveIngresada = ""; // Variable para almacenar la clave ingresada

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            'CLAVE', 
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
                    'Ingresa tu clave',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  SizedBox(height: 20),

                  // Uso del paquete pin_code_fields para ingresar la clave
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80.0), 
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.teal.shade100,
                        inactiveFillColor: Colors.white,
                        activeColor: Colors.teal,
                        inactiveColor: Colors.teal,
                        selectedColor: Colors.teal,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      onCompleted: (v) {
                        claveIngresada = v; // Almacena la clave ingresada
                        _verificarClave(context, claveIngresada); // Verifica la clave ingresada
                      },
                      onChanged: (value) {
                        claveIngresada = value; // Actualiza la clave conforme se escribe
                      },
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _verificarClave(context, claveIngresada); // Verifica la clave al presionar el botón
                    },
                    child: Text(
                      'Continuar',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Acción para olvidar clave
                    },
                    child: Text(
                      '¿Olvidaste tu clave?',
                      style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
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
