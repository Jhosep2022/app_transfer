import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';

import 'crear_eli_pass_screen.dart';

class RegistroUsuarioScreen extends StatefulWidget {
  @override
  _RegistroUsuarioScreenState createState() => _RegistroUsuarioScreenState();
}

class _RegistroUsuarioScreenState extends State<RegistroUsuarioScreen> {
  bool _isPasswordVisible = false;
  bool _acceptPrivacyPolicy = false;
  bool _acceptTermsConditions = false;

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
                  // Campos de texto
                  Row(
                    children: [
                      Expanded(child: _buildTextField("Nro Documento Rut/...")),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildTextField("Correo electrónico")),
                      SizedBox(width: 16),
                      Expanded(child: _buildTextField("Alias", hintText: "Máximo 16 caracteres")),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Casillas de verificación
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

                  // Botón Guardar
                  ElevatedButton(
                    onPressed: _acceptPrivacyPolicy && _acceptTermsConditions
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CrearEliPassScreen(),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.teal,
                      disabledBackgroundColor: Colors.teal.shade200,
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

  // Método para construir un campo de texto estándar
  Widget _buildTextField(String labelText, {String? hintText}) {
    return TextField(
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

  // Método para construir un campo de texto para la contraseña
  Widget _buildPasswordTextField(String labelText, bool isPasswordVisible, VoidCallback toggleVisibility) {
    return TextField(
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
