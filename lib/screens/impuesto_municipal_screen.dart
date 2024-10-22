import 'package:flutter/material.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/datos_legales_screen.dart';

class ImpuestoMunicipalScreen extends StatefulWidget {
  @override
  _ImpuestoMunicipalScreenState createState() => _ImpuestoMunicipalScreenState();
}

class _ImpuestoMunicipalScreenState extends State<ImpuestoMunicipalScreen> {
  final TextEditingController _ventaController = TextEditingController();
  final TextEditingController _avaluoController = TextEditingController();
  double? _impuestoResult; // Variable para almacenar el resultado del impuesto
  double? _valorBase; // Variable para almacenar el valor que se toma para calcular

  void _calcularImpuesto() {
    double? precioVenta = double.tryParse(_ventaController.text);
    double? avaluoFiscal = double.tryParse(_avaluoController.text);

    if (precioVenta != null && avaluoFiscal != null) {
      // Tomar el mayor valor entre precio de venta y avalúo fiscal
      double mayorValor = precioVenta > avaluoFiscal ? precioVenta : avaluoFiscal;

      // Calcular el 1.5% del valor mayor
      setState(() {
        _valorBase = mayorValor; // Almacenar el valor que estamos usando
        _impuestoResult = mayorValor * 0.015;
      });
    } else {
      // Si hay algún error en los inputs, muestra 0 o maneja el error
      setState(() {
        _valorBase = 0.0;
        _impuestoResult = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                            'Cálculo Impuesto Municipal', 
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ventaController,
                          decoration: InputDecoration(
                            labelText: 'Monto precio Venta',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _avaluoController,
                          decoration: InputDecoration(
                            labelText: 'Monto Avalúo fiscal',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Monto base cálculo Imptos.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Muestra el valor que se está usando para calcular el impuesto
                  if (_valorBase != null)
                    Text(
                      'Valor utilizado para cálculo: \$${_valorBase!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  SizedBox(height: 10),
                  // Muestra el resultado del cálculo del impuesto si está disponible
                  if (_impuestoResult != null)
                    Text(
                      '1.5% Impuesto a pagar: \$${_impuestoResult!.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _calcularImpuesto, // Al presionar el botón se ejecuta el cálculo
                        child: Text(
                          'CALCULAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.teal,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DatosLegalesScreen()),
                          );
                        },
                        child: Text(
                          'GUARDAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.teal,
                        ),
                      ),
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
}
