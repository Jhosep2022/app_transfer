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
  });

  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo(
      patente: json['patentecivil'],
      tipo: json['tipocivil'],
      marca: json['marcacivil'],
      modelo: json['modelocivil'],
      ano: json['anucivil'],
      estadoVenta: json['sventa'],
      estadoRobo: json['srobo'],
      estadoPerdida: json['sperdida'],
      estadoTecnica: json['stecnica'],
      estadoPermiso: json['spermiso'],
    );
  }
}
