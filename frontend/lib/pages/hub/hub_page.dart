import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:frontend/shared/routes.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/widgets/menu_item.dart';

class HubPage extends StatelessWidget {
  HubPage({
    super.key,
  });

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (!storage.read('isLoggedIn') || storage.read('isLoggedIn') == null) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (route) => false);
        },
      );
      return const Scaffold();
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 100,
                    ),
                    const Text(
                      'frontend',
                      style: TextStyles.h1,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    MenuItem(
                      icon: FontAwesomeIcons.building,
                      label: 'Propiedades',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.estates);
                      },
                    ),
                    MenuItem(
                      icon: FontAwesomeIcons.fileLines,
                      label: 'Solicitudes',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.request);
                      },
                    ),
                    MenuItem(
                      icon: FontAwesomeIcons.dollarSign,
                      label: 'Ventas',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.sales);
                      },
                    ),
                    MenuItem(
                      icon: FontAwesomeIcons.briefcase,
                      label: 'Compras',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.buys);
                      },
                    ),
                    MenuItem(
                      icon: FontAwesomeIcons.user,
                      label: 'Empleados',
                      onPressed: () {},
                    ),
                    MenuItem(
                      icon: FontAwesomeIcons.chartLine,
                      label: 'Reportes',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.reports);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
