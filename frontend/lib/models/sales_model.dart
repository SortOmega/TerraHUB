// To parse this JSON data, do
//
//     final request = requestFromJson(jsonString);

import 'dart:convert';

List<Sales> salesFromJson(String str) =>
    List<Sales>.from(json.decode(str).map((x) => Sales.fromJson(x)));

String salesToJson(List<Sales> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sales {
  final String ventaId;
  final DateTime fechaVenta;
  String? fecha;
  final String propiedadId;
  final String descripcionPropiedad;
  final double precioVenta;
  final String propietarioAntiguoId;
  final String nombrePropietarioAntiguo;
  final String propietarioNuevoId;
  final String nombrePropietarioNuevo;
  final String empleadoVendedorId;
  final String nombreEmpleadoVendedor;

  Sales({
    required this.ventaId,
    required this.fechaVenta,
    this.fecha,
    required this.propiedadId,
    required this.descripcionPropiedad,
    required this.precioVenta,
    required this.propietarioAntiguoId,
    required this.nombrePropietarioAntiguo,
    required this.propietarioNuevoId,
    required this.nombrePropietarioNuevo,
    required this.empleadoVendedorId,
    required this.nombreEmpleadoVendedor,
  });

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
        ventaId: json["ventaId"],
        fechaVenta: DateTime.parse(json["fechaVenta"]),
        propiedadId: json["propiedadId"],
        descripcionPropiedad: json["descripcionPropiedad"],
        precioVenta: json["precioVenta"],
        propietarioAntiguoId: json["propietarioAntiguoId"],
        nombrePropietarioAntiguo: json["nombrePropietarioAntiguo"],
        propietarioNuevoId: json["propietarioNuevoId"],
        nombrePropietarioNuevo: json["nombrePropietarioNuevo"],
        empleadoVendedorId: json["empleadoVendedorId"],
        nombreEmpleadoVendedor: json["nombreEmpleadoVendedor"],
      );

  Map<String, dynamic> toJson() => {
        "ventaId": ventaId,
        "fecha": fecha,
        "propiedadId": propiedadId,
        "descripcionPropiedad": descripcionPropiedad,
        "precioVenta": precioVenta,
        "propietarioAntiguoId": propietarioAntiguoId,
        "nombrePropietarioAntiguo": nombrePropietarioAntiguo,
        "propietarioNuevoId": propietarioNuevoId,
        "nombrePropietarioNuevo": nombrePropietarioNuevo,
        "empleadoVendedorId": empleadoVendedorId,
        "nombreEmpleadoVendedor": nombreEmpleadoVendedor,
      };
}
