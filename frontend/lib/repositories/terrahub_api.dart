import 'package:http/http.dart' as http;
import 'package:terrahub/models/buys_model.dart';
import 'package:terrahub/models/estate_model.dart';
import 'package:terrahub/models/client_model.dart';
import 'package:terrahub/models/employee_model.dart';
import 'dart:convert';
import 'package:terrahub/models/request_model.dart';
import 'package:terrahub/models/sales_model.dart';

class TerrahubAPI {
  Future<List<Estate>> getEstates() async {
    List<Estate> estatesList = [];

    List<String> urls = [
      'https://terrahub-production.up.railway.app/propiedades/tipoPropiedad/TPR-ALQU',
      'https://terrahub-production.up.railway.app/propiedades/tipoPropiedad/TPR-VENT'
    ];

    List<http.Response> responses =
        await Future.wait(urls.map((url) => http.get(Uri.parse(url))));

    for (http.Response response in responses) {
      if (response.statusCode == 200) {
        List<Estate> estates = estatesFromJson(response.body);
        estatesList.addAll(estates);
      } else {
        // ignore: avoid_print
        print('Error: Código de estado ${response.statusCode}');
      }
    }

    return estatesList;
  }

  Future<List<EtiquetaPropiedad>> getLabels() async {
    List<EtiquetaPropiedad> labelsList = [];

    String url =
        'https://terrahub-production.up.railway.app/propiedades/etiquetas';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<EtiquetaPropiedad> labels = etiquetasFromJson(response.body);
      labelsList.addAll(labels);
    } else {
      // ignore: avoid_print
      print('Error: Código de estado ${response.statusCode}');
    }
    return labelsList;
  }

  Future<List<Client>> getClients() async {
    List<Client> clientList = [];

    String url =
        'https://terrahub-production.up.railway.app/clientes/listaClientes';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Client> clients = clientFromJson(response.body);
      clientList.addAll(clients);
    } else {
      // ignore: avoid_print
      print('Error: Código de estado ${response.statusCode}');
    }
    return clientList;
  }

  Future<List<Employee>> getEmployees() async {
    List<Employee> employeeList = [];

    String url =
        'https://terrahub-production.up.railway.app/planillas/listaEmpleados';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Employee> clients = employeeFromJson(response.body);
      employeeList.addAll(clients);
    } else {
      // ignore: avoid_print
      print('Error: Código de estado ${response.statusCode}');
    }
    return employeeList;
  }

  Future<List<EstateType>> getEstatesType() async {
    List<EstateType> typeList = [];

    String url =
        'https://terrahub-production.up.railway.app/propiedades/tipoPropiedad';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<EstateType> types = estateTypeFromJson(response.body);
      typeList.addAll(types);
    } else {
      // ignore: avoid_print
      print('Error: Código de estado ${response.statusCode}');
    }
    return typeList;
  }

  Future<List<Sales>> getSales() async {
    List<Sales> salesList = [];

    String url =
        'https://terrahub-production.up.railway.app/contratos/listaVentasInmuebles';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Sales> types = salesFromJson(response.body);
      salesList.addAll(types);
    } else {
      // ignore: avoid_print
      print('Error: Código de estado ${response.statusCode}');
    }
    return salesList;
  }

  Future<List<Buys>> getBuys() async {
    List<Buys> buysList = [];

    String url =
        'https://terrahub-production.up.railway.app/contratos/listaComprasInmuebles';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Buys> types = buysFromJson(response.body);
      buysList.addAll(types);
    } else {
      // ignore: avoid_print
      print('Error: Código de estado ${response.statusCode}');
    }
    return buysList;
  }

  Future<List<Request>> getRequest() async {
    List<Request> buysList = [];

    String url =
        'https://terrahub-production.up.railway.app/contratos/listaSolicitudesClientes';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Request> types = requestFromJson(response.body);
      buysList.addAll(types);
    } else {
      // ignore: avoid_print
      print('Error: Código de estado ${response.statusCode}');
    }
    return buysList;
  }

  void registerEstate(Estate estate) async {
    var url = Uri.parse(
        'https://terrahub-production.up.railway.app/propiedades/registrarPropiedad');
    var data = estate.toJson();
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      // ignore: avoid_print
      print("Solicitud exitosa. Respuesta:");
    } else {
      // ignore: avoid_print
      print("Error en la solicitud. Código de estado: ${response.statusCode}");
    }
  }

  void registerRequest(Request request) async {
    var url = Uri.parse(
        'https://terrahub-production.up.railway.app/contratos/registrarSolicitudCliente');
    var data = request.toJson();
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      // ignore: avoid_print
      print("Solicitud exitosa. Respuesta:");
    } else {
      // ignore: avoid_print
      print("Error en la solicitud. Código de estado: ${response.statusCode}");
    }
  }

  void registerSales(Sales sales) async {
    var url = Uri.parse(
        'https://terrahub-production.up.railway.app/contratos/registrarVentaInmueble');
    var data = sales.toJson();
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      // ignore: avoid_print
      print("Solicitud exitosa. Respuesta:");
    } else {
      // ignore: avoid_print
      print("Error en la solicitud. Código de estado: ${response.statusCode}");
    }
  }

  void registerBuys(Buys buys) async {
    var url = Uri.parse(
        'https://terrahub-production.up.railway.app/contratos/registrarCompraInmueble');
    var data = buys.toJson();
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    if (response.statusCode == 201) {
      // ignore: avoid_print
      print("Solicitud exitosa. Respuesta:");
    } else {
      // ignore: avoid_print
      print("Error en la solicitud. Código de estado: ${response.statusCode}");
    }
  }
}
