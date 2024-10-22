import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/placa_denegada_screen.dart';
import 'package:transfer_app/screens/impuesto_municipal_screen.dart';

class PropietarioScreen extends StatefulWidget {
  @override
  _PropietarioScreenState createState() => _PropietarioScreenState();
}

class _PropietarioScreenState extends State<PropietarioScreen> {
  bool _isSearched = false; // Controla si se ha realizado la búsqueda
  TextEditingController _ppuController = TextEditingController();

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
                    height: MediaQuery.of(context).size.height * 0.22,
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
                            'PROPIETARIO(A)',
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Campo de búsqueda y botón Buscar en una fila
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ppuController,
                          textCapitalization: TextCapitalization.characters, // Fuerza mayúsculas
                          maxLength: 6, // Limita a 6 caracteres
                          decoration: InputDecoration(
                            labelText: 'P.P.U.',
                            prefixIcon: Icon(Icons.search, color: Colors.teal),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.teal),
                            ),
                          ),
                          onChanged: (value) {
                            // Convertir a mayúsculas en caso de cualquier entrada
                            _ppuController.value = _ppuController.value.copyWith(
                              text: value.toUpperCase(),
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: _ppuController.text.length),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10), // Espacio entre input y botón
                      ElevatedButton(
                        onPressed: () {
                          if (_ppuController.text.length < 6) {
                            // Redirige a PlacaDenegadaScreen si tiene menos de 6 dígitos
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlacaDenegadaScreen()),
                            );
                          } else {
                            // Redirige a ImpuestoMunicipalScreen si tiene exactamente 6 dígitos
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImpuestoMunicipalScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        ),
                        child: Text(
                          'BUSCAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Muestra los datos en un Card después de la búsqueda
                  if (_isSearched)
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tipo: SUV',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Año: 2020',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Marca: Toyota',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Modelo: Highlander',
                              style: TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Divider(thickness: 2, color: Colors.grey[300]),
                  SizedBox(height: 20),
                  _buildRadioGroup('¿Vende?'),
                  _buildRadioGroup('¿Robado?'),
                  _buildRadioGroup('¿Pérdida Total?'),
                  Divider(thickness: 2, color: Colors.grey[300]),
                  SizedBox(height: 20),
                  _buildRadioGroup('¿R. Técnica?'),
                  _buildRadioGroup('¿P. Circulación?'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton('ACTUALIZAR', context),
                      _buildActionButton('CONTINUAR', context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construye el grupo de botones radiales
  Widget _buildRadioGroup(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.black54)),
        Row(
          children: [
            Radio(value: false, groupValue: true, onChanged: (val) {}),
            Text('No'),
            Radio(value: true, groupValue: false, onChanged: (val) {}),
            Text('Sí'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (label == 'CONTINUAR') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlacaDenegadaScreen()),
          );
        }
        // Aquí puedes añadir otras acciones para el botón ACTUALIZAR
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      child: Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}
