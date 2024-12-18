import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'repetir_clave_screen.dart';

class CrearClaveIngresoScreen extends StatelessWidget {
  static ValueNotifier<String> claveNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título
            Text(
              "Crea tu clave de ingreso",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Te permitirá usar tu App",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Campos de entrada para la clave
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
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
                  print("Clave ingresada: $v");
                  CrearClaveIngresoScreen.claveNotifier.value = v; // Almacena la clave
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RepetirClaveScreen()),
                  );
                },
                onChanged: (value) {},
              ),
            ),
            SizedBox(height: 40),

            // Instrucciones
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInstructionItem("Evita usar números seguidos del Rut"),
                  _buildInstructionItem("Evita usar números seguidos"),
                  _buildInstructionItem("Que los números sean diferentes"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Row(
      children: [
        Icon(Icons.check, color: Colors.teal),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
