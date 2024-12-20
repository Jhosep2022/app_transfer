import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'crear_clave_eli_pass_screen.dart';
import 'confirmar_correo_screen.dart';

class RepiteClaveScreen extends StatefulWidget {
  @override
  _RepiteClaveScreenState createState() => _RepiteClaveScreenState();
}

class _RepiteClaveScreenState extends State<RepiteClaveScreen> {
  final TextEditingController _pinController = TextEditingController();
  String correoUsuario = ""; // Variable para almacenar el correo
  String rut = ""; // Variable para almacenar el RUT
  String region = ""; // Variable para almacenar la región
  String ciudad = ""; // Variable para almacenar la ciudad
  String comuna = ""; // Variable para almacenar la comuna
  String claveLocal = ""; // Variable para almacenar la clave local

  @override
  void initState() {
    super.initState();
    _cargarCorreoUsuario(); // Cargar el correo desde SharedPreferences
  }

  Future<void> _cargarCorreoUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      correoUsuario = prefs.getString('correo_usuario') ?? "No disponible";
      rut = prefs.getString('rut') ?? "No disponible";
      region = prefs.getString('region') ?? "No disponible";
      ciudad = prefs.getString('ciudad') ?? "No disponible";
      comuna = prefs.getString('comuna') ?? "No disponible";
      claveLocal = prefs.getString('clave_local') ?? "No disponible";
    });
  }

  @override
  void dispose() {
    _pinController.dispose(); // Liberar recursos del controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: correoUsuario.isEmpty
          ? Center(child: CircularProgressIndicator()) // Carga mientras se obtiene el correo
          : Padding(
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
                  SizedBox(height: 10),

                  // Título y subtítulo
                  Text(
                    "Repite tu clave Eli Pass",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Ingresa nuevamente la clave de 6 dígitos",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),

                  // Campos de entrada para la clave
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _pinController,
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
                        print("Clave repetida en RepiteClaveScreen: $v"); // Depuración
                        print("Clave esperada en CrearClaveScreen: ${CrearClaveScreen.claveEliPassNotifier.value}"); // Depuración

                        if (v == CrearClaveScreen.claveEliPassNotifier.value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConfirmarCorreoScreen(
                                email: correoUsuario, // Usa el correo recuperado
                                rut: rut, // Usa el rut recuperado
                                region: region, // Usa la región recuperada
                                ciudad: ciudad, // Usa la ciudad recuperada
                                comuna: comuna, // Usa la comuna recuperada
                                claveLocal: claveLocal, // Usa la clave local recuperada
                              ),
                            ),
                          );
                        } else {
                          _pinController.clear(); // Limpia el controlador
                          // Mostrar el mensaje de error y redirigir
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text("Las claves no coinciden. Serás redirigido para crear la clave nuevamente."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                          // Redirigir a la pantalla CrearClaveScreen
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => CrearClaveScreen()),
                            (route) => false,
                          );
                        }
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
