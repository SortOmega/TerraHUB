import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  final String empleadoId;
  final String plazaId;
  final String cargoId;
  final String cargoDescripcion;
  final String nombreEmpleado;
  final String identidad;
  final String telefono;
  final String email;
  final double sueldoBase;

  Employee({
    required this.empleadoId,
    required this.plazaId,
    required this.cargoId,
    required this.cargoDescripcion,
    required this.nombreEmpleado,
    required this.identidad,
    required this.telefono,
    required this.email,
    required this.sueldoBase,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        empleadoId: json["empleadoId"],
        plazaId: json["plazaId"],
        cargoId: json["cargoId"],
        cargoDescripcion: json["cargoDescripcion"],
        nombreEmpleado: json["nombreEmpleado"],
        identidad: json["identidad"],
        telefono: json["telefono"],
        email: json["email"],
        sueldoBase: json["sueldoBase"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "empleadoId": empleadoId,
        "plazaId": plazaId,
        "cargoId": cargoId,
        "cargoDescripcion": cargoDescripcion,
        "nombreEmpleado": nombreEmpleado,
        "identidad": identidad,
        "telefono": telefono,
        "email": email,
        "sueldoBase": sueldoBase,
      };
}
