import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transfer_app/components/inverted_header_clipper.dart';
import 'package:transfer_app/screens/placa_denegada_screen.dart';
import 'package:transfer_app/screens/impuesto_municipal_screen.dart';
import 'package:transfer_app/services/vehiculos_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropietarioScreen extends StatefulWidget {
  @override
  _PropietarioScreenState createState() => _PropietarioScreenState();
}

class _PropietarioScreenState extends State<PropietarioScreen> {
  bool _isSearched = false; // Controla si se ha realizado la búsqueda
  TextEditingController _ppuController = TextEditingController();
  final VehiculosService _vehiculosService = VehiculosService();

  String? tipoAutomovil;
  String? modeloAutomovil;
  String? anoAutomovil;
  String? marcaAutomovil;
  String? vendeAutomovil;
  String? robadoAutomovil;
  String? perdidoAutomovil;
  String? tecnicaAutomovil;
  String? permisoAutomovil;

  String? patenteCivil;
  String? digitoCivil;
  String? nombreCivil;
  String? vinCivil;
  String? chasisCivil;
  String? serieCivil;
  String? motorCivil;
  String? rutCivil;
  String? tipoCivil;
  String? anuCivil;
  String? modeloCivil;
  String? marcaCivil;
  String? colorCivil;

  String rutComprador = "";

  Future<void> _cargarDatosPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rutComprador = prefs.getString('rut') ?? "No disponible";
    });
  }
  
  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('vin', vinCivil ?? '');
    await prefs.setString('nro_motor', motorCivil ?? '');
    await prefs.setString('chasis', chasisCivil ?? '');
    await prefs.setString('tipo_automovil', tipoCivil ?? '');
    await prefs.setString('anio_automovil', anuCivil ?? '');
    await prefs.setString('marca_automovil', marcaCivil ?? '');
    await prefs.setString('modelo', modeloCivil ?? '');
    await prefs.setString('color', colorCivil ?? '');
    await prefs.setString('patente_venta', _ppuController.text);
  }

  @override
  void initState() {
    super.initState();
    _cargarDatosPref(); // Cargar el correo desde SharedPreferences
  }

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
                                  fontSize: 22.sp,
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
                                labelStyle: TextStyle(fontSize: 14.sp),
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
                            onPressed: () async {
                              final vehiculosService = VehiculosService();
                              final patente = _ppuController.text;

                              if (patente.isEmpty || patente.length < 6) {
                                // Mostrar un mensaje de error si la patente es inválida
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Por favor, ingresa una patente válida.')),
                                );
                                return;
                              }

                              // Llamar al servicio y obtener los datos del vehículo
                              final vehiculo = await vehiculosService.consultarRegistroInterno(patente);
                              final consultaVechiculo = await vehiculosService.consultarRegistroCivil(patente);
                              if (vehiculo != null) {                               
                                if(rutComprador != consultaVechiculo?.rutCivil){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlacaDenegadaScreen()),
                                  );
                                  return;
                                }else{
                                  // Imprimir la respuesta en consola
                                  setState(() {
                                    tipoAutomovil = vehiculo.tipo;
                                    modeloAutomovil = vehiculo.modelo;
                                    anoAutomovil = vehiculo.ano;
                                    marcaAutomovil = vehiculo.marca;
                                    vendeAutomovil = vehiculo.estadoVenta?.toLowerCase() == "sí" ? "Sí" : "No";
                                    robadoAutomovil = vehiculo.estadoRobo?.toLowerCase() == "sí" ? "Sí" : "No";
                                    perdidoAutomovil = vehiculo.estadoPerdida?.toLowerCase() == "sí" ? "Sí" : "No";
                                    tecnicaAutomovil = vehiculo.estadoTecnica?.toLowerCase() == "sí" ? "Sí" : "No";
                                    permisoAutomovil = vehiculo.estadoPermiso?.toLowerCase() == "sí" ? "Sí" : "No";
                                  });
                                  print('Vehículo encontrado: ${vehiculo.toJson()}');

                                  // Opcional: mostrar los datos en pantalla
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Vehículo encontrado')),
                                  );
                                  
                                }
                              } else {
                                // Si no se encuentra el vehículo
                                setState(() {
                                  tipoAutomovil = "No encontrado";
                                  modeloAutomovil = "Sin Modelo";
                                  anoAutomovil = "Sin año";
                                  marcaAutomovil = "Sin marca";
                                  vendeAutomovil = "No";
                                  robadoAutomovil = "No";
                                  perdidoAutomovil = "No";
                                  tecnicaAutomovil = "No";
                                  permisoAutomovil = "No";
                                  _buildRadioGroup;
                                });
                                print('No se encontró información para la patente ingresada.');

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('No se encontró información para la patente ingresada.')),
                                );
                              }
                              if (consultaVechiculo != null) {                               
                                if(rutComprador != consultaVechiculo?.rutCivil){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlacaDenegadaScreen()),
                                  );
                                  return;
                                }else{
                                  // Imprimir la respuesta en consola
                                  setState(() {
                                    patenteCivil = consultaVechiculo?.patenteCivil;
                                    digitoCivil = consultaVechiculo?.digitoCivil;
                                    nombreCivil = consultaVechiculo?.nombreCivil;
                                    vinCivil = consultaVechiculo?.vinCivil;
                                    chasisCivil = consultaVechiculo?.chasisCivil;
                                    serieCivil = consultaVechiculo?.serieCivil;
                                    motorCivil = consultaVechiculo?.motorCivil;
                                    rutCivil = consultaVechiculo?.rutCivil;
                                    tipoCivil = consultaVechiculo?.tipoCivil;
                                    anuCivil = consultaVechiculo?.anuCivil;
                                    marcaCivil = consultaVechiculo?.marcaCivil;
                                    modeloCivil = consultaVechiculo?.modeloCivil;
                                    colorCivil = consultaVechiculo?.colorCivil;
                                  });
                                  print('Consulta encontrada: ${consultaVechiculo.toJson()}');

                                  // Opcional: mostrar los datos en pantalla
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Vehículo encontrado base externa')),
                                  );
                                  
                                }
                              } else {
                                // Si no se encuentra el vehículo
                                setState(() {
                                  patenteCivil = "Sin patente";
                                  digitoCivil = "Sin dígito";
                                  nombreCivil = "Sin nombre";
                                  vinCivil = "Sin VIN";
                                  chasisCivil = "Sin chasis";
                                  serieCivil = "Sin serie";
                                  rutCivil = "Sin rut";
                                  motorCivil = "Sin motor";
                                  tipoCivil = "Sin tipo";
                                  anuCivil = "Sin año";
                                  marcaCivil = "Sin marca";
                                  modeloCivil = "Sin modelo";
                                  colorCivil = "Sin color";
                                  _buildRadioGroup;
                                });
                                print('No se encontró información para la patente ingresada.');

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('No se encontró información para la patente ingresada en base externa.')),
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
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      // Subtítulo en rojo para el primer grupo de preguntas
                      Text(
                        'Tipo: ${(tipoAutomovil == "" || tipoAutomovil == "No disponible" || tipoAutomovil == "No encontrado") ? tipoCivil : tipoAutomovil}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 10.sp,
                        ),
                      ),
                      // Subtítulo en rojo para el primer grupo de preguntas
                      Text(
                        'Año: ${(anoAutomovil == "" || anoAutomovil == "No disponible" || anoAutomovil == "Sin año") ? anuCivil : anoAutomovil}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 10.sp,
                        ),
                      ),
                      // Subtítulo en rojo para el primer grupo de preguntas
                      Text(
                        'Marca: ${(marcaAutomovil == "" || marcaAutomovil == "No disponible" || marcaAutomovil == "Sin marca") ? marcaCivil : marcaAutomovil}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 10.sp,
                        ),
                      ),
                      // Subtítulo en rojo para el primer grupo de preguntas
                      Text(
                        'Modelo: ${(modeloAutomovil == "" || modeloAutomovil == "No disponible" || modeloAutomovil == "Sin modelo") ? modeloCivil : modeloAutomovil}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 10.sp,
                        ),
                      ),


                      // Subtítulo en rojo para el primer grupo de preguntas
                      Text(
                        'ADMINISTRACION ESTADO PLACA PATENTE UNICA',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                      Divider(thickness: 2.h, color: Colors.grey[300]),
                      SizedBox(height: 20.h),

                      _buildRadioGroup(
                        label: '¿Vende?',
                        estado: vendeAutomovil,
                        onChanged: (bool value) {
                          setState(() {
                            vendeAutomovil = value ? "Sí" : "No";
                          });
                        },
                      ),
                      _buildRadioGroup(
                        label: '¿Robado?',
                        estado: robadoAutomovil,
                        onChanged: (bool value) {
                          setState(() {
                            robadoAutomovil = value ? "Sí" : "No";
                          });
                        },
                      ),
                      _buildRadioGroup(
                        label: '¿Pérdida Total?',
                        estado: perdidoAutomovil,
                        onChanged: (bool value) {
                          setState(() {
                            perdidoAutomovil = value ? "Sí" : "No";
                          });
                        },
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        'AUTORIZO LA OBTENCIÓN',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                      Divider(thickness: 2.h, color: Colors.grey[300]),
                      SizedBox(height: 20.h),

                      _buildRadioGroup(
                        label: '¿R. Técnica? $tecnicaAutomovil',
                        estado: tecnicaAutomovil,
                        onChanged: (bool value) {
                          setState(() {
                            tecnicaAutomovil = value ? "Sí" : "No";
                          });
                        },
                      ),
                      _buildRadioGroup(
                        label: '¿P. Circulación?',
                        estado: permisoAutomovil,
                        onChanged: (bool value) {
                          setState(() {
                            permisoAutomovil = value ? "Sí" : "No";
                          });
                        },
                      ),
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
  Widget _buildRadioGroup({
    required String label,
    required String? estado,
    required ValueChanged<bool> onChanged,
  }) {
    // Convertir el estado inicial a un booleano
    bool estadoInicial = estado?.toLowerCase() == "sí";
    print('Estado inicial de $label: $estado (convertido a $estadoInicial)');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
        Row(
          children: [
            // Radio para "No"
            Radio<bool>(
              value: false, // Valor de este radio
              groupValue: estadoInicial, // Valor actual del grupo
              onChanged: (val) => onChanged(val!), // Notificar cambios
            ),
            Text('No', style: TextStyle(fontSize: 12.sp)),

            // Radio para "Sí"
            Radio<bool>(
              value: true, // Valor de este radio
              groupValue: estadoInicial, // Valor actual del grupo
              onChanged: (val) => onChanged(val!), // Notificar cambios
            ),
            Text('Sí', style: TextStyle(fontSize: 12.sp)),
          ],
        ),
      ],
    );
  }


  Widget _buildActionButton(String label, BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      if(rutComprador == rutCivil){
        if (label == 'ACTUALIZAR' && tipoAutomovil != null) {
          final params = {
            'patentecivil': _ppuController.text, // PPU ingresado
            'sventa': vendeAutomovil ?? 'No',   // Estado de venta
            'srobo': robadoAutomovil ?? 'No',  // Estado de robo
            'sperdida': perdidoAutomovil ?? 'No', // Estado de pérdida total
            'novende': vendeAutomovil == 'No' ? '1' : '0', // Invertir lógica para almacenar
            'noroba': robadoAutomovil == 'No' ? '1' : '0',
            'noperdida': perdidoAutomovil == 'No' ? '1' : '0',
            'stecnica': tecnicaAutomovil ?? 'No', // Revisión técnica
            'spermiso': permisoAutomovil ?? 'No', // Permiso de circulación
          };

          try {
            final vehiculosService = VehiculosService();
            await vehiculosService.actualizarVehiculo(params);

            // Mostrar mensaje de éxito
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Datos actualizados exitosamente')),
            );
          } catch (e) {
            // Manejar errores
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al actualizar los datos: $e')),
            );
          }
        } else if (label == 'CONTINUAR' && tipoAutomovil != null) {
          // Continuar a la siguiente pantalla
          if(vendeAutomovil == "Sí"){
            await saveData();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImpuestoMunicipalScreen()),
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('El vehículo no está en venta')),
            );
          }
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlacaDenegadaScreen()),
        );
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
}
