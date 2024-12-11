class ConsultaRegistroCivil {
    final String patenteCivil;
    final String digitoCivil;
    final String nombreCivil;
    final String vinCivil;
    final String chasisCivil;
    final String serieCivil;
    final String motorCivil;
    final String rutCivil;
    final String tipoCivil;
    final String anuCivil;
    final String marcaCivil;
    final String modeloCivil;
    final String colorCivil;

  ConsultaRegistroCivil({
    required this.patenteCivil,
    required this.digitoCivil,
    required this.nombreCivil,
    required this.vinCivil,
    required this.chasisCivil,
    required this.serieCivil,
    required this.motorCivil,
    required this.rutCivil,
    required this.tipoCivil,
    required this.anuCivil,
    required this.marcaCivil,
    required this.modeloCivil,
    required this.colorCivil,
  });

  factory ConsultaRegistroCivil.fromJson(Map<String, dynamic> json) {
    return ConsultaRegistroCivil(
      patenteCivil: json['patentecivil'],
      digitoCivil: json['digitocivil'],
      nombreCivil: json['nombrecivil'],
      vinCivil: json['vincivil'],
      chasisCivil: json['chasiscivil'],
      serieCivil: json['seriecivil'],
      motorCivil: json['motorcivil'],
      rutCivil: json['rutcivil'],
      tipoCivil: json['tipocivil'],
      anuCivil: json['anucivil'],
      marcaCivil: json['marcacivil'],
      modeloCivil: json['modelocivil'],
      colorCivil: json['colorcivil'],
    );
  } 

  Map<String, String> toJson() {
    return {
      "patentecivil": patenteCivil,
      "digitocivil": digitoCivil,
      "nombrecivil": nombreCivil,
      "vincivil": vinCivil,
      "chasiscivil": chasisCivil,
      "seriecivil": serieCivil,
      "motorcivil": motorCivil,
      "rutcivil": rutCivil,
      "tipocivil": tipoCivil,
      "anucivil": anuCivil,
      "marcacivil": marcaCivil,
      "modelocivil": modeloCivil,
      "colorcivil": colorCivil,
    };
  }
}
