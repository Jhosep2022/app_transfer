class ConsultaPU {
  final String propietarioRut;
  final String propietarioNombre;
  final String patente;
  final String fechaConsulta;
  final String horaConsulta;
  final String latitud;
  final String longitud;
  final String rutConsulta;
  final String regionConsulta;

  ConsultaPU({
    required this.propietarioRut,
    required this.propietarioNombre,
    required this.patente,
    required this.fechaConsulta,
    required this.horaConsulta,
    required this.latitud,
    required this.longitud,
    required this.rutConsulta,
    required this.regionConsulta,
  });

  Map<String, String> toJson() => {
        "propie_rut": propietarioRut,
        "propie_nombre": propietarioNombre,
        "propie_patente": patente,
        "fecha_consulta": fechaConsulta,
        "hora_consulta": horaConsulta,
        "latitud_consulta": latitud,
        "longitud_consulta": longitud,
        "rut_consulta": rutConsulta,
        "region_consulta": regionConsulta,
      };
}
