import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

import 'seleccion_ubicacion_screen.dart';

class RepetirClaveScreen extends StatelessWidget {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Repita tu clave',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
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
                print("Clave repetida: $v");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeleccionUbicacionScreen()),
                );
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
