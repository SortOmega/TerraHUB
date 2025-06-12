import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:frontend/shared/routes.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/widgets/text_field_form.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final storage = GetStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.home, (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Atrás',
        ),
        title: const Text(
          'LOGIN',
          style: TextStyles.h3,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, bottom: 25.0),
                child: Image.asset(
                  'assets/logo_with_name.png',
                  height: 250,
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextFieldForm(
                        width: 320,
                        controller: emailController,
                        icon: Icons.mail,
                        lines: 1,
                        label: 'Correo',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'El correo es inválido.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldForm(
                        width: 320,
                        controller: passwordController,
                        icon: Icons.password,
                        label: 'Contraseña',
                        passwordText: true,
                        lines: 1,
                        viewButton: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'La contraseña es inválida.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  login(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
                  child: Text(
                    'Iniciar sesión',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    child: const Text(
                      'Olvidé mi contraseña',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF91D97E),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (emailController.text == 'admin@gmail.com' &&
          passwordController.text == '12345671') {
        storage.write('isLoggedIn', true);
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.hub, (route) => false);
      } else {
        QuickAlert.show(
            width: 400,
            context: context,
            type: QuickAlertType.error,
            text: 'Las credenciales son incorrectas.',
            autoCloseDuration: const Duration(seconds: 3),
            showConfirmBtn: true,
            confirmBtnText: 'Cerrar');
      }
    }
  }
}
