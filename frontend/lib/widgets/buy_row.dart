import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:terrahub/models/buys_model.dart';
import 'package:terrahub/styles/text_styles.dart';
import 'package:terrahub/widgets/ink_buttons.dart';

// ignore: must_be_immutable
class BuyRow extends StatelessWidget {
  BuyRow({
    super.key,
    required this.buy,
  });

  Buys buy;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: Center(
            child: Text(
              buy.compraId,
              style: TextStyles.h4,
            ),
          ),
        ),
        SizedBox(
          width: 240,
          child: Center(
            child: Text(
              buy.descripcionPropiedad,
              style: TextStyles.h4,
            ),
          ),
        ),
        SizedBox(
          width: 180,
          child: Center(
            child: Text(
              buy.nombreEmpleadoComprador,
              style: TextStyles.h4,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Center(
            child: Text(
              'L. ${NumberFormat.currency(locale: 'es_HN', symbol: '').format(buy.precioCompra)}',
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
    );
  }
}
