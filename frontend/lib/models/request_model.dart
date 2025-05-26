import 'dart:convert';

List<Request> requestFromJson(String str) =>
    List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String requestToJson(List<Request> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  final String solicitudId;
  final String tipoSolicitudId;
  final String tipoSolicitudDescripcion;
  final String descripcionSolicitud;
  final String clienteId;
  final String nombre;
  final String? apellido;
  final String identidad;
  final String? email;
  final String? telefono;
  final DateTime fechaCreacion;
  final String empleadoPlazaEncargado;
  final String nombreEmpleadoEncargado;
  final String estadoId;
  final String estadoDescripcion;
  final dynamic fechaProcesada;
  final dynamic empleadoTerminoSolicitud;
  final dynamic nombreEmpleadoTermina;

  Request({
    required this.solicitudId,
    required this.tipoSolicitudId,
    required this.tipoSolicitudDescripcion,
    required this.descripcionSolicitud,
    required this.clienteId,
    required this.nombre,
    required this.apellido,
    required this.identidad,
    required this.email,
    required this.telefono,
    required this.fechaCreacion,
    required this.empleadoPlazaEncargado,
    required this.nombreEmpleadoEncargado,
    required this.estadoId,
    required this.estadoDescripcion,
    required this.fechaProcesada,
    required this.empleadoTerminoSolicitud,
    required this.nombreEmpleadoTermina,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        solicitudId: json["solicitudId"],
        tipoSolicitudId: json["tipoSolicitudId"],
        tipoSolicitudDescripcion: json["tipoSolicitudDescripcion"],
        descripcionSolicitud: json["descripcionSolicitud"],
        clienteId: json["clienteId"],
        nombre: json["nombreCliente"],
        apellido: json["nombreCliente"],
        identidad: json["identidad"],
        email: json["email"],
        telefono: json["telefono"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        empleadoPlazaEncargado: json["empleadoPlazaEncargado"],
        nombreEmpleadoEncargado: json["nombreEmpleadoEncargado"],
        estadoId: json["estadoId"],
        estadoDescripcion: json["estadoDescripcion"],
        fechaProcesada: json["fechaProcesada"],
        empleadoTerminoSolicitud: json["empleadoTerminoSolicitud"],
        nombreEmpleadoTermina: json["nombreEmpleadoTermina"],
      );

  Map<String, dynamic> toJson() => {
        "solicitudId": solicitudId,
        "tipoSolicitudDescripcion": tipoSolicitudDescripcion,
        "clienteId": clienteId,
        //--

        "nombre": nombre,
        "apellido": apellido,
        "identidad": identidad,
        "email": email,
        "telefono": telefono,
        "descripcionSolicitud": descripcionSolicitud,
        "tipoSolicitudId": tipoSolicitudId,
        //--
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "empleadoPlazaEncargado": empleadoPlazaEncargado,
        "nombreEmpleadoEncargado": nombreEmpleadoEncargado,
        "estadoId": estadoId,
        "estadoDescripcion": estadoDescripcion,
        "fechaProcesada": fechaProcesada,
        "empleadoTerminoSolicitud": empleadoTerminoSolicitud,
        "nombreEmpleadoTermina": nombreEmpleadoTermina,
      };
}
