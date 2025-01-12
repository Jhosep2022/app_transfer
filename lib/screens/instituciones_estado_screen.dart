import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/revision_tecnica_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class InstitucionesEstadoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    height: MediaQuery.of(context).size.height * 0.23*0.75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0*0.75),
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
                          SizedBox(height: 20*0.75),
                          Text(
                            'INSTITUCIONES DEL ESTADO',
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
                children: [
                  _buildConsultaButton(
                      'CONSULTA AVALUO FISCAL EN SII',
                      'https://www4.sii.cl/vehiculospubui/#/searchtasacion'),
                  SizedBox(height: 10),
                  _buildConsultaButton(
                      'CONSULTA MULTAS PPU EN REGISTRO CIVIL',
                      'https://consultamultas.srcei.cl/ConsultaMultas/consultaMultasExterna.do'),
                  SizedBox(height: 10),
                  _buildConsultaButton(
                      'VALIDA PADRÓN EN REGISTRO CIVIL',
                      'https://www.registrocivil.cl/OficinaInternet/verificacion/verificacioncertificado.srcei'),
                  SizedBox(height: 10),
                  _buildConsultaButton(
                      'BUSCA PPU EN FISCALÍA',
                      'http://www.fiscaliadechile.cl/Fiscalia/victimas/buscador.jsp'),
                  SizedBox(height: 10),
                  _buildConsultaButton(
                      'PPU ENCARGO POR ROBO: AUTO SEGURO PDI',
                      'https://www.autoseguro.gob.cl/'),
                  SizedBox(height: 10),
                  _buildUltimaConsultaButton(context),
                  SizedBox(height: 30),
                  // Botón Volver
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'VOLVER',
                      style: TextStyle(
                        color: Colors.white, // Texto blanco
                        fontWeight: FontWeight.bold, // Negrita
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.teal, // Color del botón
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

  // Método para crear los botones de consulta con redirección a un enlace
  Widget _buildConsultaButton(String text, String url) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _launchURL(url),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold, // Negrita
              color: Colors.black, // Texto negro
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.grey[200], // Fondo gris claro
        ),
      ),
    );
  }

  // Botón para la última consulta que redirige a una pantalla
  Widget _buildUltimaConsultaButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RevisionTecnicaScreen()),
          );
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'CONSULTA R.TÉCNICA MINISTERIO TRANSPORTES',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold, // Negrita
              color: Colors.black, // Texto negro
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.grey[200], // Fondo gris claro
        ),
      ),
    );
  }

  // Método para abrir el enlace en el navegador
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('No se pudo abrir el enlace $url');
    }
  }
}
