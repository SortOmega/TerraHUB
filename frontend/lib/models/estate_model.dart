import 'dart:convert';

List<Estate> estatesFromJson(String str) =>
    List<Estate>.from(json.decode(str).map((x) => Estate.fromJson(x)));

String estatesToJson(List<Estate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Estate {
  final String propiedadId;
  final String descripcion;
  final String tipoPropiedadId;
  final String tipoPropiedadDesc;
  final String? propietarioId;
  final String propietarioNombre;
  final String? propietarioDni;
  final String? urlImagen;
  final String pais;
  final String departamento;
  final String direccion;
  final double? precio;
  final List<EtiquetaPropiedad>? etiquetasPropiedad;

  Estate({
    required this.propiedadId,
    required this.descripcion,
    required this.tipoPropiedadId,
    required this.tipoPropiedadDesc,
    required this.propietarioId,
    required this.propietarioNombre,
    required this.propietarioDni,
    required this.urlImagen,
    required this.pais,
    required this.departamento,
    required this.direccion,
    required this.precio,
    required this.etiquetasPropiedad,
  });

  factory Estate.fromJson(Map<String, dynamic> json) {
    List<EtiquetaPropiedad> etiquetasPropiedadList = [];

    if (json["etiquetasPropiedad"] != null) {
      etiquetasPropiedadList = List<EtiquetaPropiedad>.from(
        json["etiquetasPropiedad"].map((x) => EtiquetaPropiedad.fromJson(x)),
      );
    }
    return Estate(
      propiedadId: json["propiedadId"],
      descripcion: json["descripcion"],
      tipoPropiedadId: json["tipoPropiedadId"]!,
      tipoPropiedadDesc: json["tipoPropiedadDesc"]!,
      propietarioId: json["propietarioId"],
      propietarioNombre: json["propietarioNombre"],
      propietarioDni: json["propietarioDNI"],
      urlImagen: json["urlImagen"],
      pais: json["pais"]!,
      departamento: json["departamento"],
      direccion: json["direccion"],
      precio: json["precioActual"]?.toDouble(),
      etiquetasPropiedad: etiquetasPropiedadList,
    );
  }

  Map<String, dynamic> toJson() => {
        "propiedadId": propiedadId,
        "descripcion": descripcion,
        "tipoPropiedadId": tipoPropiedadId,
        "tipoPropiedadDesc": tipoPropiedadDesc,
        "propietarioId": propietarioId,
        "propietarioNombre": propietarioNombre,
        "propietarioDNI": propietarioDni,
        "urlImagen": urlImagen,
        "pais": pais,
        "departamento": departamento,
        "direccion": direccion,
        "precio": precio,
        "etiquetasPropiedad": etiquetasPropiedad != null
            ? etiquetasPropiedad!.map((x) => x.toJson()).toList()
            : [],
      };
}

List<EtiquetaPropiedad> etiquetasFromJson(String str) =>
    List<EtiquetaPropiedad>.from(
        json.decode(str).map((x) => EtiquetaPropiedad.fromJson(x)));

class EtiquetaPropiedad {
  final String? propiedadId;
  final String etiquetaId;
  final String nombreEtiqueta;
  final bool esCuantificable;
  int? cantidad;

  EtiquetaPropiedad({
    this.propiedadId,
    required this.etiquetaId,
    required this.nombreEtiqueta,
    required this.esCuantificable,
    this.cantidad,
  });

  factory EtiquetaPropiedad.fromJson(Map<String, dynamic> json) =>
      EtiquetaPropiedad(
        propiedadId: json["propiedadId"],
        etiquetaId: json["etiquetaId"],
        nombreEtiqueta: json["nombreEtiqueta"]!,
        esCuantificable: json["esCuantificable"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "propiedadId": propiedadId,
        "etiquetaId": etiquetaId,
        "nombreEtiqueta": nombreEtiqueta,
        "esCuantificable": esCuantificable,
        "cantidad": cantidad,
      };
}

List<EstateType> estateTypeFromJson(String str) =>
    List<EstateType>.from(json.decode(str).map((x) => EstateType.fromJson(x)));

String estateTypeToJson(List<EstateType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EstateType {
  final String tipoPropiedadId;
  final String descripcion;

  EstateType({
    required this.tipoPropiedadId,
    required this.descripcion,
  });

  factory EstateType.fromJson(Map<String, dynamic> json) => EstateType(
        tipoPropiedadId: json["tipoPropiedadId"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "tipoPropiedadId": tipoPropiedadId,
        "descripcion": descripcion,
      };
}
