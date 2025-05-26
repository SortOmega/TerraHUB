// To parse this JSON data, do
//
//     final buys = buysFromJson(jsonString);

import 'dart:convert';

List<Buys> buysFromJson(String str) =>
    List<Buys>.from(json.decode(str).map((x) => Buys.fromJson(x)));

String buysToJson(List<Buys> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buys {
  final String compraId;
  final String fechaCompra;
  final String propiedadId;
  final String descripcionPropiedad;
  final double precioCompra;
  final String propietarioAntiguoId;
  final String nombrePropietarioAntiguo;
  final String propietarioNuevoId;
  final String nombrePropietarioNuevo;
  final String empleadoCompradorId;
  final String nombreEmpleadoComprador;

  Buys({
    required this.compraId,
    required this.fechaCompra,
    required this.propiedadId,
    required this.descripcionPropiedad,
    required this.precioCompra,
    required this.propietarioAntiguoId,
    required this.nombrePropietarioAntiguo,
    required this.propietarioNuevoId,
    required this.nombrePropietarioNuevo,
    required this.empleadoCompradorId,
    required this.nombreEmpleadoComprador,
  });

  factory Buys.fromJson(Map<String, dynamic> json) => Buys(
        compraId: json["compraId"],
        fechaCompra: json["fechaCompra"],
        propiedadId: json["propiedadId"],
        descripcionPropiedad: json["descripcionPropiedad"],
        precioCompra: json["precioCompra"],
        propietarioAntiguoId: json["propietarioAntiguoId"],
        nombrePropietarioAntiguo: json["nombrePropietarioAntiguo"],
        propietarioNuevoId: json["propietarioNuevoId"],
        nombrePropietarioNuevo: json["nombrePropietarioNuevo"],
        empleadoCompradorId: json["empleadoCompradorId"],
        nombreEmpleadoComprador: json["nombreEmpleadoComprador"],
      );

  Map<String, dynamic> toJson() => {
        "compraId": compraId,
        "fechaCompra": fechaCompra,
        "propiedadId": propiedadId,
        "descripcionPropiedad": descripcionPropiedad,
        "precioCompra": precioCompra,
        "propietarioAntiguoId": propietarioAntiguoId,
        "nombrePropietarioAntiguo": nombrePropietarioAntiguo,
        "propietarioNuevoId": propietarioNuevoId,
        "nombrePropietarioNuevo": nombrePropietarioNuevo,
        "empleadoCompradorId": empleadoCompradorId,
        "nombreEmpleadoComprador": nombreEmpleadoComprador,
      };
}
