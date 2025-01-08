import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'repite_clave_screen.dart';

class CrearClaveScreen extends StatelessWidget {
  static ValueNotifier<String> claveEliPassNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                Icons.lock_outline,
                size: 80,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 20),

            // Título y subtítulo
            Text(
              "Crea tu clave Eli Pass",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "La clave debe ser de 6 números\nque sea fácil de recordar",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Campos de entrada para la clave
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
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
                  print("Clave creada en CrearClaveScreen: $v"); // Depuración
                  CrearClaveScreen.claveEliPassNotifier.value = v;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RepiteClaveScreen()),
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
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
