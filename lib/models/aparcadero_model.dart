class Aparcadero {
  final String fechaActualizada;
  final String horaActualizada;
  final String mesActualizada;
  final String patenteFisica;
  final String lugarActualizada;
  final String condicionAparcada;
  final String regionAparcadero;
  final String comunaAparcadero;
  final String nombreAparcadero;
  final String correoEmitido;

  Aparcadero({
    required this.fechaActualizada,
    required this.horaActualizada,
    required this.mesActualizada,
    required this.patenteFisica,
    required this.lugarActualizada,
    required this.condicionAparcada,
    required this.regionAparcadero,
    required this.comunaAparcadero,
    required this.nombreAparcadero,
    required this.correoEmitido,
  });

  factory Aparcadero.fromJson(Map<String, dynamic> json) {
    return Aparcadero(
      fechaActualizada: json['fecha_actualizada'],
      horaActualizada: json['hora_actualizada'],
      mesActualizada: json['mes_actualizada'],
      patenteFisica: json['patente_fisica'],
      lugarActualizada: json['lugar_actualizada'],
      condicionAparcada: json['condicion_aparcada'],
      regionAparcadero: json['region_aparcadero'],
      comunaAparcadero: json['comuna_aparcadero'],
      nombreAparcadero: json['nombre_aparcadero'],
      correoEmitido: json['correo_emitido'],
    );
  }
}
