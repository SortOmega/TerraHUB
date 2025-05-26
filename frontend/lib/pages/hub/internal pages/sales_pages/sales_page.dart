import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:terrahub/models/sales_model.dart';
import 'package:terrahub/repositories/terrahub_api.dart';
import 'package:terrahub/shared/routes.dart';
import 'package:terrahub/styles/text_styles.dart';
import 'package:terrahub/widgets/ink_buttons.dart';
import 'package:terrahub/widgets/sale_row.dart';

class SalesPage extends StatelessWidget {
  SalesPage({super.key});

  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    if (!storage.read('isLoggedIn') || storage.read('isLoggedIn') == null) {
      return const Scaffold();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.hub, (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Atrás',
        ),
        title: const Text(
          'VENTAS',
          style: TextStyles.h3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkButton(
                  bordeRadius: 0,
                  backgroundColor: const Color(0xFF68CDEC),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.createSales);
                  },
                  child: const Text(
                    'Registrar venta',
                    style: TextStyles.h5,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    InkButton(
                      onPressed: () {},
                      child: const Icon(FontAwesomeIcons.sliders),
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: TextEditingController(),
                        decoration: const InputDecoration(
                          label: Text('Búsqueda'),
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const TableHeader(),
            Expanded(
              child: FutureBuilder(
                future: TerrahubAPI().getSales(),
                builder: (context, AsyncSnapshot<List<Sales>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.cloud_off, size: 100),
                          Text(
                            '${snapshot.error}',
                            style: const TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.hourglass_empty_outlined, size: 100),
                        Text(
                          'No hay ventas',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ));
                  }

                  snapshot.data!;
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => SaleRow(
                      sale: snapshot.data![index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: const Color(0xFF68CDEC),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                'ID',
                style: TextStyles.h5,
              ),
            ),
          ),
          SizedBox(
            width: 240,
            child: Center(
              child: Text(
                'Título',
                style: TextStyles.h5,
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Center(
              child: Text(
                'Nuevo propietario',
                style: TextStyles.h5,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                'Precio',
                style: TextStyles.h5,
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: Center(
              child: Text(
                'Acciones',
                style: TextStyles.h5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
