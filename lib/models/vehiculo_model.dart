class Vehiculo {
  final String patente;
  final String tipo;
  final String marca;
  final String modelo;
  final String ano;
  final String estadoVenta;
  final String estadoRobo;
  final String estadoPerdida;
  final String estadoTecnica;
  final String estadoPermiso;
  final String region;

  Vehiculo({
    required this.patente,
    required this.tipo,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.estadoVenta,
    required this.estadoRobo,
    required this.estadoPerdida,
    required this.estadoTecnica,
    required this.estadoPermiso,
    required this.region,
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      patente: json['patentecivil'],
      tipo: json['tipocivil'],
      marca: json['marcacivil'],
      modelo: json['modelocivil'],
      ano: json['anucivil'],
      estadoVenta: json['sventa'] ?? 'No',
      estadoRobo: json['srobo'] ?? 'No',
      estadoPerdida: json['sperdida'] ?? 'No',
      estadoTecnica: json['stecnica'] ?? 'No',
      estadoPermiso: json['spermiso'] ?? 'No',
      region: json['noregion'] ?? 'No',
    );
  }
    // Convertir un Vehiculo a JSON
  Map<String, dynamic> toJson() {
    return {
      'patentecivil': patente,
      'tipocivil': tipo,
      'marcacivil': marca,
      'modelocivil': modelo,
      'anucivil': ano,
      'sventa': estadoVenta,
      'srobo': estadoRobo,
      'sperdida': estadoPerdida,
      'stecnica': estadoTecnica,
      'spermiso': estadoPermiso,
      'noregion': region,
    };
  }
}
