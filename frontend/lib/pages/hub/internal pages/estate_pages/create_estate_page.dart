import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:frontend/models/client_model.dart';
import 'package:frontend/models/estate_model.dart';
import 'package:frontend/repositories/firebase_storage.dart';
import 'package:frontend/repositories/terrahub_api.dart';
import 'package:frontend/shared/routes.dart';
// import 'package:frontend/repositories/firebase_storage.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/widgets/button_drop_down.dart';
import 'package:frontend/widgets/ink_buttons.dart';
import 'package:frontend/widgets/labels_selection.dart';
import 'package:frontend/widgets/text_field_form.dart';
import 'package:frontend/widgets/upload_images.dart';
import 'dart:math';

// ignore: must_be_immutable
class CreateStatePage extends StatelessWidget {
  CreateStatePage({super.key});

  final storage = GetStorage();

  final formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  RxString selectedClient = ''.obs;
  RxString selectedType = ''.obs;
  RxString selectedCountry = 'Honduras'.obs;
  RxString selectedDepto = 'Cortés'.obs;
  List<EstateType> typesEstates = [];
  List<Client> clientsObject = [];
  RxList<EtiquetaPropiedad> etiquetas = <EtiquetaPropiedad>[].obs;
  List<TextEditingController> etiquetasCant = <TextEditingController>[];
  RxBool contieneCuantificable = false.obs;

  Uint8List? image;
  String? url;

  @override
  Widget build(BuildContext context) {
    idController.text = generateID();
    if (!storage.read('isLoggedIn') || storage.read('isLoggedIn') == null) {
      return const Scaffold();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.estates, (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Atrás',
        ),
        title: const Text(
          'CREAR PROPIEDAD',
          style: TextStyles.h3,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectImage(
                    imageUrl: url,
                    onImageSelected: (img) {
                      image = img;
                    },
                  ),
                  Form(
                    key: formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextFieldForm(
                                  enabled: false,
                                  width: 300,
                                  controller: idController,
                                  icon: Icons.abc_outlined,
                                  label: 'ID',
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: FutureBuilder(
                                    future: TerrahubAPI().getEstatesType(),
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
                                                'Aún no hay tipo de propiedad',
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      typesEstates = snapshot.data!;
                                      List<String> type = snapshot.data!
                                          .map((type) => type.descripcion)
                                          .toSet()
                                          .toList();
                                      selectedType = type[0].obs;
                                      return ButtonDropDown(
                                        width: 300,
                                        label: 'Tipo de propiedad',
                                        icon: Icons.account_tree_outlined,
                                        selectedValue: selectedType,
                                        options: type,
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextFieldForm(
                                  width: 300,
                                  controller: descriptionController,
                                  icon: Icons.short_text,
                                  length: 255,
                                  label: 'Descripción',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor, completa este campo.';
                                    }
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
                                    clientsObject = snapshot.data!;
                                    List<String> clients = snapshot.data!
                                        .map((client) => client.nombre)
                                        .toSet()
                                        .toList();
                                    selectedClient = clients[0].obs;
                                    return ButtonDropDown(
                                      width: 300,
                                      label: 'Cliente',
                                      icon: Icons.person,
                                      selectedValue: selectedClient,
                                      options: clients,
                                    );
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ButtonDropDown(
                                  width: 300,
                                  label: 'País',
                                  icon: Icons.location_on,
                                  selectedValue: selectedCountry,
                                  options: const [
                                    'Honduras',
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ButtonDropDown(
                                  width: 300,
                                  label: 'Departamento',
                                  icon: Icons.location_city_outlined,
                                  selectedValue: selectedDepto,
                                  options: const [
                                    "Atlántida",
                                    "Choluteca",
                                    "Colón",
                                    "Comayagua",
                                    "Copán",
                                    "Cortés",
                                    "El Paraíso",
                                    "Francisco Morazán",
                                    "Gracias a Dios",
                                    "Intibucá",
                                    "Islas de la Bahía",
                                    "La Paz",
                                    "Lempira",
                                    "Ocotepeque",
                                    "Olancho",
                                    "Santa Bárbara",
                                    "Valle",
                                    "Yoro"
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextFieldForm(
                                  width: 300,
                                  controller: addressController,
                                  icon: Icons.directions,
                                  length: 255,
                                  label: 'Dirección',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor, completa este campo.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: TextFieldForm(
                                  width: 300,
                                  controller: priceController,
                                  icon: Icons.attach_money,
                                  label: 'Precio',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Por favor, completa este campo.';
                                    }
                                    if (!value.isNumericOnly) {
                                      return 'Este campo solo admite números.';
                                    }
                                    if (int.parse(value) < 500000) {
                                      return 'El precio ingresado es demasiado bajo.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: InkButton(
                  bordeRadius: 15,
                  backgroundColor: const Color(0xFF68CDEC),
                  hoverColor: Colors.black26,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => LabelSelection(
                        selectedLabels: etiquetas,
                        controllersCant: etiquetasCant,
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 57, vertical: 12),
                    child: Text(
                      'Seleccionar etiquetas',
                      style: TextStyles.h5,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.center,
                        children: etiquetas.map((etiqueta) {
                          contieneCuantificable = etiquetas
                              .any((etiqueta) =>
                                  etiqueta.esCuantificable == true)
                              .obs;
                          return InkWell(
                            mouseCursor: SystemMouseCursors.grab,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              if (etiqueta.esCuantificable) {
                                showDialog(
                                  context: context,
                                  builder: (context) => SizedBox(
                                    width: 300,
                                    child: SimpleDialog(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 100, vertical: 20),
                                      title: Text(
                                          'Especifique la cantidad de: ${etiqueta.nombreEtiqueta}'),
                                      children: [
                                        TextFieldForm(
                                          width: 150,
                                          controller: etiquetasCant[
                                              etiquetas.indexOf(etiqueta)],
                                          icon: Icons.numbers_rounded,
                                          label: 'Cantidad',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Debe ingresar una cantidad';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Chip(
                              label: Text(etiqueta.nombreEtiqueta),
                              backgroundColor: etiqueta.esCuantificable
                                  ? const Color(0xFF91D97E)
                                  : Colors.grey[300],
                              elevation: 5,
                              shadowColor: Colors.black,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      if (contieneCuantificable.value)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text.rich(
                            TextSpan(
                              text: '* Debe indicar las cantidades en las ',
                              children: [
                                TextSpan(
                                  text: 'etiquetas cuantificables',
                                  style: TextStyle(
                                    color: Color(0xFF91D97E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          save(context);
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Text('Guardar'),
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
    id = 'PR${uuid.substring(0, 8)}';
    return id;
  }

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String typeEstateUpload = typesEstates
          .firstWhere((element) => element.descripcion == selectedType.value)
          .tipoPropiedadId;
      String clientUploadID = clientsObject
          .firstWhere((element) => element.nombre == selectedClient.value)
          .clienteId;
      String clientUploadIden = clientsObject
          .firstWhere((element) => element.nombre == selectedClient.value)
          .identidad;

      for (int i = 0; i < etiquetas.length; i++) {
        if (etiquetas[i].esCuantificable) {
          if (etiquetasCant[i].text.isNotEmpty) {
            etiquetas[i].cantidad = int.parse(etiquetasCant[i].text);
          } else {
            QuickAlert.show(
              width: 350,
              context: context,
              type: QuickAlertType.error,
              text:
                  'Debe especificar la cantidad de las etiquetas cuantificables.',
              confirmBtnText: 'Cerrar',
              autoCloseDuration: const Duration(seconds: 5),
              confirmBtnColor: const Color(0xFF91D97E),
            );
          }
        }
      }
      if (image != null) {
        final estate = Estate(
          propiedadId: idController.text,
          descripcion: descriptionController.text,
          tipoPropiedadId: typeEstateUpload,
          tipoPropiedadDesc: selectedType.value,
          propietarioId: clientUploadID,
          propietarioNombre: selectedClient.value,
          propietarioDni: clientUploadIden,
          urlImagen: await uploadImage(image!, '/Propiedades'),
          pais: selectedCountry.value,
          departamento: selectedDepto.value,
          direccion: addressController.text,
          precio: double.parse(priceController.text),
          etiquetasPropiedad: etiquetas,
        );
        TerrahubAPI().registerEstate(estate);
        // ignore: use_build_context_synchronously
        QuickAlert.show(
          width: 400,
          context: context,
          type: QuickAlertType.success,
          title: 'Registrado con éxito',
          text:
              'La propiedad con código: ${idController.text}: ${descriptionController.text} se ha registrado exitosamente.',
          showConfirmBtn: true,
        );
      } else {
        QuickAlert.show(
          width: 350,
          context: context,
          type: QuickAlertType.error,
          text: 'Debe adjuntar una imagen de la propiedad.',
          confirmBtnText: 'Cerrar',
          autoCloseDuration: const Duration(seconds: 5),
          confirmBtnColor: const Color(0xFF91D97E),
        );
      }
    }
  }
}
