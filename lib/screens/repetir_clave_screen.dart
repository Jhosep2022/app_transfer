import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../components/inverted_header_clipper.dart';
import 'seleccion_ubicacion_screen.dart';
import 'crear_clave_ingreso_screen.dart';

class RepetirClaveScreen extends StatefulWidget {
  @override
  _RepetirClaveScreenState createState() => _RepetirClaveScreenState();
}

class _RepetirClaveScreenState extends State<RepetirClaveScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose(); // Liberar recursos del controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Cabecera curvada con el mismo diseño del HomeScreen
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Botón de retroceso
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Repita tu clave',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 40), // Espaciador para mantener simetría
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),

          // Campo de entrada para repetir la clave
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 95.0),
            child: PinCodeTextField(
              appContext: context,
              length: 4,
              controller: _pinController, // Asocia el controlador al campo
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
              onCompleted: (v) async {
                if (v == CrearClaveIngresoScreen.claveNotifier.value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeleccionUbicacionScreen(clave: v),
                    ),
                  );
                } else {
                  _pinController.clear(); // Limpia el controlador
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Las claves no coinciden. Serás redirigido a la pantalla anterior."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                  // Redirigir a la pantalla anterior
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CrearClaveIngresoScreen()),
                    (route) => false,
                  );
                }
              },
              onChanged: (value) {},
            ),
          ),
          SizedBox(height: 40),

          // Mensaje de instrucción
          Text(
            "Si te equivocas, volverás a intentar",
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
