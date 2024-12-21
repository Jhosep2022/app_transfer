import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para manejar fechas y horas
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/services/cliente_service.dart';
import 'alert_crear_eli_pass_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegistroUsuarioScreen extends StatefulWidget {
  final ClienteService _usuarioService = ClienteService();

  // Datos recibidos de la pantalla anterior
  final String clave;
  final String region;
  final String comuna;
  final String ciudad;

  RegistroUsuarioScreen({
    required this.clave,
    required this.region,
    required this.comuna,
    required this.ciudad,
  });

  @override
  _RegistroUsuarioScreenState createState() => _RegistroUsuarioScreenState();
}

class _RegistroUsuarioScreenState extends State<RegistroUsuarioScreen> {
  // Variables para capturar datos del usuario
  final TextEditingController _rutController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _aliasController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _acceptPrivacyPolicy = false;
  bool _acceptTermsConditions = false;

  String rut = "";
  String numeroSerie = "";
  String tipo = "";
  String latitud = "";
  String longitud = "";
  String serial = "";
  
  Map<String, String> getParams() {
    DateTime now = DateTime.now();
    String xhora = DateFormat('h:mm:a').format(now).trim();
    String mfecha = DateFormat('yyyy-MM-dd').format(now);

    return {
      "rut_usuario": rut,                // Valor obtenido de SharedPreferences
      "tipo_usuario": tipo,              // Valor obtenido de SharedPreferences
      "correo_usuario": _correoController.text,
      "region_usuario": widget.region,
      "ciudad_usuario": widget.ciudad,
      "comuna_usuario": widget.comuna,
      "numero_serie": numeroSerie,       // Valor obtenido de SharedPreferences
      "fecha_registro": mfecha,
      "hora_registro": xhora,
      "verificado": "No",
      "latitud_usuario": latitud,        // Valor obtenido de SharedPreferences
      "longitud_usuario": longitud,      // Valor obtenido de SharedPreferences
      "activo": "No",
    };
  }
  
  Map<String, String> getRegionParams(){
    // Obtener la fecha actual
    DateTime now = DateTime.now();
    String xhora = DateFormat('h:mm:a').format(now).trim(); // Hora en formato h:mm a
    String mfecha = DateFormat('yyyy-MM-dd').format(now);   // Fecha en formato yyyy-MM-dd

    // Crear el mapa de parámetros
    Map<String, String> paramsn = {
      "rut_region": rut,
      "correo_region": _correoController.text,
      "region_region": widget.region,
      "ciudad_region": widget.ciudad,
      "comuna_region": widget.comuna,
      "fecharegion": mfecha,
      "horaregion": xhora,
      "avisado": "No",
      "latitud_region": latitud,
      "longitud_region": longitud,
    };

    return paramsn;
  }

  Future<void> _saveToLocalStorage() async {
    // Guardar los datos en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('correo_usuario', _correoController.text ?? "No disponible");
    await prefs.setString('region', widget.region ?? "No disponible");
    await prefs.setString('ciudad', widget.ciudad ?? "No disponible");
    await prefs.setString('comuna', widget.comuna ?? "No disponible");
    await prefs.setString('clave_local', _claveController.text ?? "No disponible");
  }


  // Método para cargar datos desde SharedPreferences
  Future<void> _cargarDatosSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      numeroSerie = prefs.getString('serial') ?? "";
      rut = prefs.getString('rut') ?? "";
      tipo = prefs.getString('tipo') ?? "";
      latitud = prefs.getString('latitud') ?? "";
      longitud = prefs.getString('longitud') ?? "";
      serial = prefs.getString('serial') ?? "";
    });
  }

  Future<void> _guardarUsuario() async {
    print("Guardando usuario...");
    // Validar que todos los campos estén llenos
    if (_rutController.text.isEmpty ||
        _claveController.text.isEmpty ||
        _correoController.text.isEmpty ||
        _aliasController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Todos los campos son obligatorios.")),
      );
      return;
    }

    // Validar el formato del correo
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(_correoController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El correo electrónico no tiene un formato válido.")),
      );
      return;
    }

    // Validar que _claveController coincide con clave
    if (_claveController.text != widget.clave) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("La clave ingresada no coincide.")),
      );
      return;
    }

    // Validar que _rutController coincide con rut
    if (_rutController.text != serial) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El RUT ingresado no coincide.")),
      );
      return;
    }

    // Validar términos y condiciones
    if (!_acceptPrivacyPolicy || !_acceptTermsConditions) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Debes aceptar los términos y la política de privacidad.")),
      );
      return;
    }

    // Si todas las validaciones pasan
    final params = getParams();
    try {
      await widget._usuarioService.agregarUsuario(params);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario guardado exitosamente.")),
      );
      _enviarCorreo();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar el usuario: $e")),
      );
    }
  }

  Future<void> _guardarRegion() async {
    print("Guardando region...");
    // Validar que todos los campos estén llenos
    if (_rutController.text.isEmpty ||
        _claveController.text.isEmpty ||
        _correoController.text.isEmpty ||
        _aliasController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Todos los campos son obligatorios.")),
      );
      return;
    }

    // Validar el formato del correo
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(_correoController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El correo electrónico no tiene un formato válido.")),
      );
      return;
    }

    // Validar que _claveController coincide con clave
    if (_claveController.text != widget.clave) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("La clave ingresada no coincide.")),
      );
      return;
    }

    // Validar que _rutController coincide con rut
    if (_rutController.text != rut) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El RUT ingresado no coincide.")),
      );
      return;
    }

    // Validar términos y condiciones
    if (!_acceptPrivacyPolicy || !_acceptTermsConditions) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Debes aceptar los términos y la política de privacidad.")),
      );
      return;
    }

    // Si todas las validaciones pasan
    final params = getRegionParams();
    try {
      await widget._usuarioService.agregarRegionCliente(params);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Region guardada exitosamente.")),
      );
      _guardarUsuario();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar el usuario: $e")),
      );
    }
  }

  Future<void> _enviarCorreo() async {
    print("Enviando correo...");
    // Si todas las validaciones pasan
    try {
      await widget._usuarioService.enviarCorreoOperador(rut);
      _saveToLocalStorage();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Correo enviado exitosamente.")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CrearEliPassScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al enviar correo: $e")),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    _cargarDatosSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                          'REGISTRO DE USUARIOS',
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
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              controller: _rutController, labelText: "Nro Documento Serial/...")),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildPasswordTextField(
                          "Clave de tu App",
                          _isPasswordVisible,
                          () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          _claveController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              controller: _correoController, labelText: "Correo electrónico")),
                      SizedBox(width: 16),
                      Expanded(
                          child: _buildTextField(
                              controller: _aliasController,
                              labelText: "Alias",
                              hintText: "Máximo 16 caracteres")),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptPrivacyPolicy,
                        onChanged: (value) {
                          setState(() {
                            _acceptPrivacyPolicy = value!;
                          });
                        },
                        activeColor: Colors.teal,
                      ),
                      Text("Acepto Política de Privacidad"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTermsConditions,
                        onChanged: (value) {
                          setState(() {
                            _acceptTermsConditions = value!;
                          });
                        },
                        activeColor: Colors.teal,
                      ),
                      Text("Acepto Términos y Condiciones"),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _acceptPrivacyPolicy && _acceptTermsConditions ? () {
                      print("Guardando region1...");
                      _guardarRegion();
                      }:null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.teal,
                    ),
                    child: Text(
                      'GUARDAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String labelText, String? hintText}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildPasswordTextField(String labelText, bool isPasswordVisible, VoidCallback toggleVisibility,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
