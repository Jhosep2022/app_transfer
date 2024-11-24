import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Tamaño base (ej. iPhone X)
      builder: (context, child) {
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
                        height: 200.h,
                        width: 375.w,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 40.h,
                          ),
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
                              SizedBox(height: 20.h),
                              Text(
                                'PROPIETARIO(A)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
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
                  padding: EdgeInsets.all(16.w),
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
                                labelStyle: TextStyle(fontSize: 16.sp),
                                prefixIcon: Icon(Icons.search, color: Colors.teal, size: 20.sp),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
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
                          SizedBox(width: 10.w), // Espacio entre input y botón
                          ElevatedButton(
                            onPressed: () {
                              if (_ppuController.text.length < 6) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PlacaDenegadaScreen()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ImpuestoMunicipalScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                            ),
                            child: Text(
                              'BUSCAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Subtítulo en rojo para el primer grupo de preguntas
                      Text(
                        'ADMINISTRACION ESTADO PLACA PATENTE UNICA',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      Divider(thickness: 2.h, color: Colors.grey[300]),
                      SizedBox(height: 20.h),

                      _buildRadioGroup('¿Vende?'),
                      _buildRadioGroup('¿Robado?'),
                      _buildRadioGroup('¿Pérdida Total?'),

                      SizedBox(height: 20.h),
                      Text(
                        'AUTORIZO LA OBTENCIÓN',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                      Divider(thickness: 2.h, color: Colors.grey[300]),
                      SizedBox(height: 20.h),

                      _buildRadioGroup('¿R. Técnica?'),
                      _buildRadioGroup('¿P. Circulación?'),
                      SizedBox(height: 20.h),

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
      },
    );
  }

  // Construye el grupo de botones radiales
  Widget _buildRadioGroup(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.black54)),
        Row(
          children: [
            Radio(value: false, groupValue: true, onChanged: (val) {}),
            Text('No', style: TextStyle(fontSize: 14.sp)),
            Radio(value: true, groupValue: false, onChanged: (val) {}),
            Text('Sí', style: TextStyle(fontSize: 14.sp)),
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
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
      ),
      child: Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.white)),
    );
  }
}
