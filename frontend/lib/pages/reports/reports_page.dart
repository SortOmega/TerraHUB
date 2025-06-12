import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:frontend/shared/routes.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/widgets/menu_item.dart';

final storage = GetStorage();

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

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
        appBar: AppBar(
          toolbarHeight: 100,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.hub, (route) => false);
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Atrás',
          ),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.file_present,
                  size: 60,
                ),
                Text(
                  'Reportes',
                  style: TextStyles.h2,
                )
              ],
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                MenuItem(
                  icon: FontAwesomeIcons.fileInvoiceDollar,
                  label: 'Ventas',
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.salesreports);
                  },
                ),
                MenuItem(
                  icon: FontAwesomeIcons.fileInvoice,
                  label: 'Compras',
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.buysreports);
                  },
                ),
                MenuItem(
                  icon: FontAwesomeIcons.userClock,
                  label: 'Desempeño',
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.performancereports);
                  },
                ),
                MenuItem(
                  icon: FontAwesomeIcons.chartPie,
                  label: 'Evaluación operativa',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, Routes.operationalevaluationreports);
                  },
                ),
                MenuItem(
                  icon: FontAwesomeIcons.chartColumn,
                  label: 'Rendimiento de ventas',
                  onPressed: () {
                    Navigator.pushNamed(
                        context, Routes.salesperformancereports);
                  },
                ),
                MenuItem(
                  icon: FontAwesomeIcons.chartGantt,
                  label: 'Mínima demanda',
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.minimumdemandreports);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
