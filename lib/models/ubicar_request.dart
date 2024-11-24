class UbicarRequest {
  final String rutPatente;
  final String patente;
  final String rutConsulta;
  final double latitud;
  final double longitud;
  final String fecha;
  final String hora;
  final String correo;
  final String ciudad;
  final String comuna;
  final String regionPatente;
  final String regionConsulta;
  final String chasisCivil;
  final String chasisVende;

  UbicarRequest({
    required this.rutPatente,
    required this.patente,
    required this.rutConsulta,
    required this.latitud,
    required this.longitud,
    required this.fecha,
    required this.hora,
    required this.correo,
    required this.ciudad,
    required this.comuna,
    required this.regionPatente,
    required this.regionConsulta,
    required this.chasisCivil,
    required this.chasisVende,
  });

  Map<String, String> toJson() {
    return {
      "rutpatenteubicar": rutPatente,
      "patenteubicar": patente,
      "rutconsultaubicar": rutConsulta,
      "latitudubicar": latitud.toString(),
      "longitudubicar": longitud.toString(),
      "fechaubicar": fecha,
      "horaubicar": hora,
      "correoubicar": correo,
      "ciudadubicar": ciudad,
      "comunaubicar": comuna,
      "regionubicar": regionPatente,
      "regionconsulta": regionConsulta,
      "chasis_civil": chasisCivil,
      "chasis_vende": chasisVende,
    };
  }
}
