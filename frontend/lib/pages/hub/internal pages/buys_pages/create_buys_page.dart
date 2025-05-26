import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:terrahub/models/buys_model.dart';
import 'package:terrahub/models/employee_model.dart';
import 'package:terrahub/models/estate_model.dart';
import 'package:terrahub/repositories/terrahub_api.dart';
import 'package:terrahub/shared/routes.dart';
import 'package:terrahub/styles/text_styles.dart';
import 'package:terrahub/widgets/button_drop_down.dart';
import 'package:terrahub/widgets/text_field_form.dart';

// ignore: must_be_immutable
class CreateBuysPage extends StatelessWidget {
  CreateBuysPage({super.key});

  TextEditingController idController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController ownerController = TextEditingController();
  TextEditingController newOwnerController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxList<Estate> estates = <Estate>[].obs;
  RxString selectedClient = ''.obs;
  RxString selectedEmployee = ''.obs;
  RxString selectedEstateID = ''.obs;
  RxString urlImage = ''.obs;
  RxString selectedEstateDescription = ''.obs;
  List<Employee> employeesObject = [];
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    idController.text = generateID();
    newOwnerController.text = 'Terra Inmuebles';
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
                context, Routes.buys, (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Atrás',
        ),
        title: const Text(
          'REGISTRAR COMPRA',
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
                                enabled: false,
                                width: 350,
                                controller: idController,
                                icon: Icons.abc_outlined,
                                label: 'ID de compra',
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
                              label: 'Precio de compra',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, completa este campo.';
                                }
                                if (!value.isNumericOnly) {
                                  return 'Este campo solo admite números.';
                                }
                                if (double.parse(value) < 500000) {
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 28),
                            child: TextFieldForm(
                              enabled: false,
                              width: 350,
                              controller: newOwnerController,
                              icon: Icons.attach_money_rounded,
                              label: 'Nuevo Propietario',
                              validator: (value) {
                                return null;
                              },
                            ),
                          ),
                          FutureBuilder(
                            future: TerrahubAPI().getEmployees(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
    id = 'CR${uuid.substring(0, 8)}';
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

      String employeeID = employeesObject
          .firstWhere(
              (element) => element.nombreEmpleado == selectedEmployee.value)
          .empleadoId;
      Buys buy = Buys(
          compraId: idController.text,
          fechaCompra: fechaFormateada,
          propiedadId: selectedEstateID.value,
          descripcionPropiedad: descriptionController.text,
          precioCompra: double.parse(priceController.text),
          propietarioAntiguoId: newOwnerController.text,
          nombrePropietarioAntiguo: ownerController.text,
          propietarioNuevoId: 'clientID',
          nombrePropietarioNuevo: 'TerraInmuebles',
          empleadoCompradorId: employeeID,
          nombreEmpleadoComprador: selectedEmployee.value);
      TerrahubAPI().registerBuys(buy);
      QuickAlert.show(
        width: 400,
        context: context,
        type: QuickAlertType.success,
        title: 'Registrado con éxito',
        text:
            'La venta con código: ${buy.compraId}: ${descriptionController.text} se ha registrado exitosamente.',
        showConfirmBtn: true,
      );
    }
  }
}
