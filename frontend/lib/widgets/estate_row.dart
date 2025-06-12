import 'package:flutter/material.dart';
import 'package:frontend/models/estate_model.dart';
import 'package:frontend/shared/routes.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frontend/widgets/ink_buttons.dart';
import 'package:intl/intl.dart';

class EstateRow extends StatelessWidget {
  const EstateRow({super.key, required this.estate});

  final Estate estate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.estateinfo, arguments: estate);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: Center(
                child: Text(
                  estate.propiedadId,
                  style: TextStyles.h4,
                ),
              ),
            ),
            SizedBox(
              width: 240,
              child: Center(
                child: Text(
                  estate.descripcion,
                  style: TextStyles.h4,
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: Center(
                child: (estate.urlImagen != null)
                    ? CachedNetworkImage(imageUrl: estate.urlImagen!)
                    : const Text('NO IMAGE'),
              ),
            ),
            SizedBox(
              width: 150,
              child: Center(
                child: Text(
                  'L. ${NumberFormat.currency(locale: 'es_HN', symbol: '').format(estate.precio)}',
                  style: TextStyles.h4,
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkButton(
                    toolTip: 'Actualizar',
                    hoverColor: Colors.black26,
                    onPressed: () {},
                    child: const Icon(
                      Icons.update,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkButton(
                    toolTip: 'Eliminar',
                    hoverColor: Colors.black26,
                    onPressed: () {},
                    child: const Icon(
                      Icons.delete_forever_outlined,
                      size: 40,
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
}
