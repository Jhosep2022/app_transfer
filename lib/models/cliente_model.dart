class Cliente {
  final String rutCliente;
  final String tipoCliente;
  final String correoCliente;
  final String regionCliente;
  final String comunaCliente;
  final String ciudadCliente;
  final String latitudCliente;
  final String longitudCliente;

  Cliente({
    required this.rutCliente,
    required this.tipoCliente,
    required this.correoCliente,
    required this.regionCliente,
    required this.comunaCliente,
    required this.ciudadCliente,
    required this.latitudCliente,
    required this.longitudCliente,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      rutCliente: json['rutcliente'],
      tipoCliente: json['tipocliente'],
      correoCliente: json['correo_cliente'],
      regionCliente: json['region_cliente'],
      comunaCliente: json['comuna_cliente'],
      ciudadCliente: json['ciudad_cliente'],
      latitudCliente: json['latitud_cliente'],
      longitudCliente: json['longitud_cliente'],
    );
  }
}
