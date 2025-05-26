import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:terrahub/models/client_model.dart';
import 'package:terrahub/models/employee_model.dart';
import 'package:terrahub/models/estate_model.dart';
import 'package:terrahub/models/sales_model.dart';
import 'package:terrahub/repositories/terrahub_api.dart';
import 'package:terrahub/shared/routes.dart';
import 'package:terrahub/styles/text_styles.dart';
import 'package:terrahub/widgets/button_drop_down.dart';
import 'package:terrahub/widgets/text_field_form.dart';
import 'package:quickalert/quickalert.dart';

// ignore: must_be_immutable
class CreateSalesPage extends StatelessWidget {
  CreateSalesPage({super.key});

  TextEditingController idController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxList<Estate> estates = <Estate>[].obs;
  RxString selectedClient = ''.obs;
  RxString selectedEstateID = ''.obs;
  RxString urlImage = ''.obs;
  RxString selectedEstateDescription = ''.obs;
  List<Client> clientsObject = [];
  List<Employee> employeesObject = [];
  RxString selectedEmployee = ''.obs;
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    idController.text = generateID();
    dateController.text =
        '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
    if (!storage.read('isLoggedIn') || storage.read('isLoggedIn') == null) {
      return const Scaffold();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.sales, (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Atrás',
        ),
        title: const Text(
          'REGISTRAR VENTA',
          style: TextStyles.h3,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: TerrahubAPI().getEstates(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Estate>> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          size: 64,
                          color: Colors.grey,
                        ),
                        Text(
                          'Aún no hay clientes registrados',
                        ),
                      ],
                    ),
                  );
                }
                estates = snapshot.data!.obs;
                List<String> estatesID = snapshot.data!
                    .map((estate) => estate.propiedadId)
                    .toSet()
                    .toList();
                selectedEstateID = estatesID[0].obs;
                descriptionController.text = estates[0].descripcion;
                ownerController.text = estates[0].propietarioNombre;
                urlImage.value = estates[0].urlImagen!;
                return Form(
                  key: formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Imagen'),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF68CDEC),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: 350,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => CachedNetworkImage(
                                      imageUrl: urlImage.value,
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: TextFieldForm(
                                width: 350,
                                controller: idController,
                                enabled: false,
                                icon: Icons.abc_outlined,
                                label: 'ID de venta',
                                validator: (value) {
                                  return null;
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: SizedBox(
                              width: 350,
                              height: 60,
                              child: TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  label: const Text('Fecha'),
                                  prefixIcon: const Icon(Icons.date_range),
                                  suffix: IconButton(
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle),
                                    onPressed: () {
                                      selectDate(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ButtonDropDown(
                              width: 350,
                              label: 'ID de propiedad',
                              icon: Icons.abc,
                              selectedValue: selectedEstateID,
                              options: estatesID,
                              content: estates,
                              onChanged: (content) {
                                descriptionController.text =
                                    content.descripcion;
                                ownerController.text =
                                    content.propietarioNombre;
                                urlImage.value = content.urlImagen!;
                              },
                            ),
                          ),
                          TextFieldForm(
                            enabled: false,
                            width: 350,
                            controller: descriptionController,
                            icon: Icons.short_text_rounded,
                            label: 'Descripción',
                            validator: (value) {
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: TextFieldForm(
                              width: 350,
                              controller: priceController,
                              icon: Icons.attach_money_rounded,
                              label: 'Precio de venta',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, completa este campo.';
                                }
                                if (!value.isNumericOnly) {
                                  return 'Este campo solo admite números.';
                                }
                                if (double.parse(value) <
                                    estates
                                        .firstWhere((element) =>
                                            element.propiedadId ==
                                            selectedEstateID.value)
                                        .precio!) {
                                  return 'El precio ingresado es demasiado bajo.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: TextFieldForm(
                              enabled: false,
                              width: 350,
                              controller: ownerController,
                              icon: Icons.person,
                              label: 'Propietario antiguo',
                              validator: (value) {
                                return null;
                              },
                            ),
                          ),
                          FutureBuilder(
                              future: TerrahubAPI().getClients(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                }
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.info,
                                          size: 64,
                                          color: Colors.grey,
                                        ),
                                        Text(
                                          'Aún no hay clientes registrados',
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                clientsObject = snapshot.data!
                                    .where((element) =>
                                        element.tipoClienteId == 'TC-COMP')
                                    .toList();
                                List<String> clients = clientsObject
                                    .map((client) => client.nombre)
                                    .toSet()
                                    .toList();
                                selectedClient = clients[0].obs;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 25),
                                  child: ButtonDropDown(
                                    width: 350,
                                    label: 'Nuevo propietario',
                                    icon: Icons.person,
                                    selectedValue: selectedClient,
                                    options: clients,
                                  ),
                                );
                              }),
                          FutureBuilder(
                            future: TerrahubAPI().getEmployees(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Employee>> snapshot) {
                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              }
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Aún no hay clientes registrados',
                                      ),
                                    ],
                                  ),
                                );
                              }
                              employeesObject = snapshot.data!
                                  .where((element) =>
                                      element.cargoId == 'CARG-AGENT')
                                  .toList();
                              selectedEmployee =
                                  employeesObject[0].nombreEmpleado.obs;
                              List<String> employees = employeesObject
                                  .map((employee) => employee.nombreEmpleado)
                                  .toSet()
                                  .toList();
                              return ButtonDropDown(
                                width: 350,
                                label: 'Empleado encargado',
                                icon: Icons.person,
                                selectedValue: selectedEmployee,
                                options: employees,
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          register(context);
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text('Registrar'),
        ),
      ),
    );
  }

  String generateID() {
    String id;
    var random = Random.secure();
    var uuid = List.generate(32, (index) {
      return (index == 12)
          ? 4
          : (index == 16)
              ? (random.nextInt(4) + 8)
              : random.nextInt(16);
    }).map((value) {
      return value.toRadixString(16);
    }).join();
    uuid =
        '${uuid.substring(0, 8)}-${uuid.substring(8, 12)}-${uuid.substring(12, 16)}-${uuid.substring(16, 20)}-${uuid.substring(20)}';
    id = 'VT${uuid.substring(0, 8)}';
    return id;
  }

  final Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      helpText: 'Fecha:',
      cancelText: 'Cancelar',
      confirmText: 'Seleccionar',
      errorInvalidText: 'Esta fecha no existe',
      errorFormatText: 'Esta fecha no existe',
      fieldLabelText: 'Ingrese una fecha',
      context: context,
      initialDate: selectedDate.value != DateTime.now()
          ? selectedDate.value
          : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      dateController.text =
          '${selectedDate.value.day}/${selectedDate.value.month}/${selectedDate.value.year}';
    }
  }

  void register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      String fechaFormateada =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);
      String clientID = clientsObject
          .firstWhere((element) => element.nombre == selectedClient.value)
          .clienteId;
      String employeeID = employeesObject
          .firstWhere(
              (element) => element.nombreEmpleado == selectedEmployee.value)
          .empleadoId;
      Sales sale = Sales(
        ventaId: 'null',
        fechaVenta: selectedDate.value,
        fecha: fechaFormateada,
        propiedadId: selectedEstateID.value,
        descripcionPropiedad: descriptionController.text,
        precioVenta: double.parse(priceController.text),
        propietarioAntiguoId: ownerController.text,
        nombrePropietarioAntiguo: ownerController.text,
        propietarioNuevoId: clientID,
        nombrePropietarioNuevo: selectedClient.value,
        empleadoVendedorId: employeeID,
        nombreEmpleadoVendedor: selectedEmployee.value,
      );
      TerrahubAPI().registerSales(sale);
      QuickAlert.show(
        width: 400,
        context: context,
        type: QuickAlertType.success,
        title: 'Registrado con éxito',
        text:
            'La venta con código: ${sale.ventaId}: ${descriptionController.text} se ha registrado exitosamente.',
        showConfirmBtn: true,
      );
    }
  }
}
