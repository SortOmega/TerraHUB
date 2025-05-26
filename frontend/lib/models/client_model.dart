import 'dart:convert';

List<Client> clientFromJson(String str) =>
    List<Client>.from(json.decode(str).map((x) => Client.fromJson(x)));

String clientToJson(List<Client> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Client {
  final String clienteId;
  final String nombre;
  final String identidad;
  final String email;
  final String telefono;
  final String tipoClienteId;

  Client({
    required this.clienteId,
    required this.nombre,
    required this.identidad,
    required this.email,
    required this.telefono,
    required this.tipoClienteId,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        clienteId: json["clienteId"],
        nombre: json["nombre"],
        identidad: json["identidad"],
        email: json["email"],
        telefono: json["telefono"],
        tipoClienteId: json["tipoClienteId"],
      );

  Map<String, dynamic> toJson() => {
        "clienteId": clienteId,
        "nombre": nombre,
        "identidad": identidad,
        "email": email,
        "telefono": telefono,
        "tipoClienteId": tipoClienteId,
      };
}
