import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/estate_model.dart';
import 'package:frontend/styles/text_styles.dart';

class EstateInfoPage extends StatelessWidget {
  EstateInfoPage({
    super.key,
    required this.estate,
  });

  final Estate estate;
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
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Atrás',
        ),
        title: const Text(
          'DETALLE DE LA PROPIEDAD',
          style: TextStyles.h3,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: estate.urlImagen!,
                    width: 500,
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 600,
                        child: Text(
                          estate.descripcion,
                          style: TextStyles.h3,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: const Color(0xFF68CDEC),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'L. ${NumberFormat.currency(locale: 'es_HN', symbol: '').format(estate.precio)}',
                            style: TextStyles.h3,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Referencia: ${estate.propiedadId}',
                        style: TextStyles.h4,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Contacto: +504 ${generarNumero()}',
                        style: TextStyles.h4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'UBICACIÓN',
                          style: TextStyles.h3,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'País',
                              style: TextStyles.h4,
                            ),
                            Text(
                              estate.pais,
                              style: TextStyles.h4,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Departamento',
                              style: TextStyles.h4,
                            ),
                            Text(
                              estate.departamento,
                              style: TextStyles.h4,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Dirección',
                              style: TextStyles.h4,
                            ),
                            Text(
                              estate.direccion,
                              style: TextStyles.h4,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  SizedBox(
                    width: 600,
                    child: Wrap(
                      children: estate.etiquetasPropiedad!
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                label: Text(e.cantidad != null
                                    ? '${e.cantidad} ${e.nombreEtiqueta}'
                                    : e.nombreEtiqueta),
                                backgroundColor: const Color(0xFF91D97E),
                                elevation: 5,
                                shadowColor: Colors.black,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String generarNumero() {
    Random random = Random();
    // Elegir aleatoriamente el primer dígito entre 3, 8 o 9
    int primerDigito = [3, 8, 9][random.nextInt(3)];
    // Generar los siguientes 3 dígitos de forma aleatoria
    String siguientesDigitos = random.nextInt(1000).toString().padLeft(3, '0');
    // Generar los siguientes 4 dígitos de forma aleatoria
    String siguientesCuatroDigitos =
        random.nextInt(10000).toString().padLeft(4, '0');
    // Combinar los números con el guion en el formato deseado
    String numero = '$primerDigito$siguientesDigitos-$siguientesCuatroDigitos';
    return numero;
  }
}
