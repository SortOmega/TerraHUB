import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/sales_model.dart';
import 'package:frontend/styles/text_styles.dart';
import 'package:frontend/widgets/ink_buttons.dart';

// ignore: must_be_immutable
class SaleRow extends StatelessWidget {
  SaleRow({
    super.key,
    required this.sale,
  });

  Sales sale;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: Center(
            child: Text(
              sale.ventaId,
              style: TextStyles.h4,
            ),
          ),
        ),
        SizedBox(
          width: 240,
          child: Center(
            child: Text(
              sale.descripcionPropiedad,
              style: TextStyles.h4,
            ),
          ),
        ),
        SizedBox(
          width: 180,
          child: Center(
            child: Text(
              sale.nombrePropietarioNuevo,
              style: TextStyles.h4,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Center(
            child: Text(
              'L. ${NumberFormat.currency(locale: 'es_HN', symbol: '').format(sale.precioVenta)}',
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
