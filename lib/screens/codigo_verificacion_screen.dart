import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:transfer_app/screens/home_screen.dart';
import 'package:transfer_app/services/clave_remota_service.dart';

class CodigoVerificacionScreen extends StatelessWidget {
  final String email;
  final String rut;
  final String clave;
  final ClaveRemotaService _usuarioService = ClaveRemotaService(); // Instancia del servicio

  CodigoVerificacionScreen({
    required this.email,
    required this.rut,
    required this.clave,
  });

  Future<void> _guardarClaveRemota(BuildContext context, String v) async {
    print("Guardando clave remota...");
    // Validar que sean iguales las claves
    if (clave != v) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Las claves no coinciden.")),
      );
      return;
    }

    try {
      await _usuarioService.actualizarClaveRemota(rut, clave);      
      // Navega a la nueva pantalla después de confirmar el código
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar la clave remota: $e")),
      );
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contenedor con icono y texto
            Container(
              padding: EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.security,
                    size: 60,
                    color: Colors.teal,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Ingresa el Código",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "que recibiste en tu correo",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Campo de entrada de código de 6 dígitos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
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
                  _guardarClaveRemota(context, v);
                  print("Código ingresado: $v");
                },
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de destino después de confirmar el código
class NuevaPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva Pantalla"),
      ),
      body: Center(
        child: Text("Bienvenido a la nueva pantalla"),
      ),
    );
  }
}
