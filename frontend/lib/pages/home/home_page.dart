import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:frontend/models/request_model.dart';
import 'package:frontend/repositories/terrahub_api.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/widgets/button_drop_down.dart';
import 'package:frontend/widgets/ink_buttons.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:intl/intl.dart';
import 'package:frontend/widgets/text_field_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final storage = GetStorage();

  final GlobalKey homeSection = GlobalKey();
  final GlobalKey usSection = GlobalKey();
  final GlobalKey contactSection = GlobalKey();
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  RxString selectedType = 'COMPRA'.obs;

  void navigateToSection(double offset, int seconds, int milliseconds) {
    scrollController.animateTo(
      offset,
      duration: Duration(seconds: seconds, milliseconds: milliseconds),
      curve: Curves.easeInOut,
    );
  }

  String getCurrentRoute() {
    String url = html.window.location.href;
    Uri uri = Uri.parse(url);
    return uri.path;
  }

  @override
  Widget build(BuildContext context) {
    if (getCurrentRoute() == '/' || getCurrentRoute() == '/login') {
      storage.write('isLoggedIn', false);
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: InkButton(
            hoverColor: Colors.transparent,
            onPressed: () {
              navigateToSection(0, 0, 550);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Terra Inmuebles'),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                InkButton(
                  onPressed: () {
                    navigateToSection(850, 0, 550);
                  },
                  hoverColor: const Color(0xFFF2F2F2),
                  child: const Text(
                    'Nosotros',
                    style: TextStyles.inkButtonsText,
                  ),
                ),
                InkButton(
                  onPressed: () {},
                  hoverColor: const Color(0xFFF2F2F2),
                  child: const Text(
                    'Anuncios',
                    style: TextStyles.inkButtonsText,
                  ),
                ),
                InkButton(
                  onPressed: () {},
                  hoverColor: const Color(0xFFF2F2F2),
                  child: const Text(
                    'Blog',
                    style: TextStyles.inkButtonsText,
                  ),
                ),
                InkButton(
                  onPressed: () {
                    navigateToSection(1800, 0, 550);
                  },
                  hoverColor: const Color(0xFFF2F2F2),
                  child: const Text(
                    'Contáctanos',
                    style: TextStyles.inkButtonsText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HomeSection(homeSection: homeSection),
            UsSection(usSection: usSection),
            ContactSection(
              formKey: formKey,
              contactSection: contactSection,
              nameController: nameController,
              lastNameController: lastNameController,
              idController: idController,
              emailController: emailController,
              phoneController: phoneController,
              messageController: messageController,
              selectedType: selectedType,
              dateController: dateController,
            )
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.contactSection,
    required this.nameController,
    required this.lastNameController,
    required this.idController,
    required this.emailController,
    required this.phoneController,
    required this.messageController,
    required this.selectedType,
    required this.dateController,
    required this.formKey,
  });

  final GlobalKey<State<StatefulWidget>> contactSection;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController idController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController messageController;
  final RxString selectedType;
  final TextEditingController dateController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    dateController.text = getCurrentTimestamp();
    return Container(
      color: Colors.white,
      key: contactSection,
      width: double.infinity,
      height: 780,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 30),
            child: Text(
              'Contáctanos',
              style: TextStyles.h2,
            ),
          ),
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Información personal',
                      style: TextStyles.h4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF466B73)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFieldForm(
                                width: 350,
                                controller: nameController,
                                icon: Icons.abc_outlined,
                                label: 'Nombre',
                                length: 35,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, completa este campo.';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFieldForm(
                                width: 350,
                                controller: lastNameController,
                                icon: Icons.abc_outlined,
                                label: 'Apellido',
                                length: 35,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, completa este campo.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFieldForm(
                                width: 350,
                                controller: idController,
                                icon: Icons.credit_card,
                                length: 15,
                                label: 'Identidad',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, completa este campo.';
                                  }
                                  RegExp regex = RegExp(r'^\d{4}-\d{4}-\d{5}$');
                                  if (!regex.hasMatch(value)) {
                                    return 'El formato es incorrecto. "XXXX-XXXX-XXXXX."';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFieldForm(
                                width: 350,
                                controller: emailController,
                                icon: Icons.mail,
                                label: 'Correo electrónico',
                                validator: (value) {
                                  RegExp regex = RegExp(r'\.([a-zA-Z]{2,6})$');
                                  if (value!.isEmpty) {
                                    return 'Por favor, completa este campo.';
                                  }
                                  if (!regex.hasMatch(value)) {
                                    return 'La extensión del correo electrónico es inválida.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            TextFieldForm(
                              width: 350,
                              controller: phoneController,
                              icon: Icons.phone,
                              length: 9,
                              label: 'Teléfono',
                              validator: (value) {
                                RegExp regex = RegExp(r'^[983]\d{3}-\d{4}$');
                                if (value!.isEmpty) {
                                  return 'Por favor, completa este campo.';
                                }
                                if (!regex.hasMatch(value)) {
                                  return 'El formato del número de teléfono es inválido.';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Información de la solicitud',
                      style: TextStyles.h4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF466B73)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFieldForm(
                                width: 350,
                                controller: messageController,
                                icon: Icons.abc_outlined,
                                lines: 4,
                                length: 255,
                                label: 'Mensaje',
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
                              child: ButtonDropDown(
                                width: 345,
                                label: 'Tipo de solicitud',
                                icon: Icons.insert_drive_file_outlined,
                                selectedValue: selectedType,
                                options: const ['VENTA', 'COMPRA'],
                              ),
                            ),
                            TextFieldForm(
                              enabled: false,
                              width: 350,
                              controller: dateController,
                              icon: Icons.date_range,
                              label: 'Fecha de la solicitud',
                              validator: (value) {
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 30),
                      child: TextButton(
                        onPressed: () {
                          send(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text('Enviar'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getCurrentTimestamp() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedDate = formatter.format(now);
    return formattedDate;
  }

  void send(BuildContext context) {
    if (formKey.currentState!.validate()) {
      String typeRequest;
      selectedType.value == 'VENTA'
          ? typeRequest = 'TCON-VENT'
          : typeRequest = 'TCON-COMP';
      Request request = Request(
          solicitudId: 'null',
          tipoSolicitudId: typeRequest,
          tipoSolicitudDescripcion: selectedType.value,
          descripcionSolicitud: messageController.text,
          clienteId: 'null',
          nombre: nameController.text,
          apellido: lastNameController.text,
          identidad: idController.text,
          email: emailController.text,
          telefono: '+504 ${phoneController.text}',
          fechaCreacion: DateTime.now(),
          empleadoPlazaEncargado: 'null',
          nombreEmpleadoEncargado: 'null',
          estadoId: 'ES-NUEV',
          estadoDescripcion: 'NUEVA',
          fechaProcesada: null,
          empleadoTerminoSolicitud: null,
          nombreEmpleadoTermina: null);
      TerrahubAPI().registerRequest(request);
      QuickAlert.show(
        width: 400,
        context: context,
        type: QuickAlertType.success,
        title: 'Solicitud enviada con éxito.',
        text:
            'Muchas gracias ${nameController.text} por contactarnos, su solicitud será atendida lo más pronto posible.',
        autoCloseDuration: const Duration(seconds: 4, milliseconds: 300),
        showConfirmBtn: true,
      );
    }
  }
}

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.homeSection,
  });

  final GlobalKey homeSection;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: homeSection,
      width: double.infinity,
      height: 850,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/home_picture.jpg'), fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            child: Image.asset(
              'assets/logo_with_name.png',
              width: 500,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            child: Text(
              'Venta y alquiler de casas y apartamentos',
              style: TextStyles.h1,
            ),
          ),
        ],
      ),
    );
  }
}

class UsSection extends StatelessWidget {
  const UsSection({
    super.key,
    required this.usSection,
  });

  final GlobalKey<State<StatefulWidget>> usSection;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: usSection,
      color: Colors.white,
      height: 900,
      width: double.infinity,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50, left: 50, right: 50, bottom: 20),
            child: Text(
              'Conoce sobre Nosotros',
              style: TextStyles.h2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'home_picture.jpeg',
                  width: 575,
                  height: 575,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 675,
                  height: 600,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '10 años de experiencia',
                        style: TextStyles.h3,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'TERRA INMUEBLES es un emprendimiento familiar creado con trabajo duro y el propósito de ayudar a dueños de inmuebles a alquilar o vender sus propiedades en Tegucigalpa. Desde sus inicios en una pequeña oficina acondicionada en la sala de su casa de habitación, en la cual María de la Cruz Medina (QDDG) madre de Fernando José Medina(fundador) acompañada de su perrita aguacatera llamada “Princesa” a la que adoraba mucho y metía a la sala para no sentirse sola cuando atendía el teléfono, mientras el mostraba propiedades de Lunes a Domingo y las publicaba por la noche, han tenido la visión de llevar el negocio de bienes raíces a altos estándares, con un esquema formal, estructurado y de procesos definidos enmarcados en la ética y la transparencia. A lo largo de los años han ayudado a cientos de personas a encontrar su hogar; también han colaborado con Embajadas, Diplomáticos, Empresarios y Ejecutivos en satisfacer sus necesidades inmobiliarias.\n\nEL HERALDO les ha considerado en diversas ocasiones para puntos de vista del sector; en poco tiempo han creado una buena imagen y amplia red de contactos para beneficio de sus clientes.',
                        textAlign: TextAlign.justify,
                        style: TextStyles.h4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
