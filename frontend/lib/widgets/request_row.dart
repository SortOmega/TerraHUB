import 'package:flutter/material.dart';
import 'package:terrahub/models/request_model.dart';
import 'package:terrahub/shared/routes.dart';
import 'package:terrahub/styles/text_styles.dart';
import 'package:terrahub/widgets/ink_buttons.dart';

// ignore: must_be_immutable
class RequestRow extends StatelessWidget {
  RequestRow({
    super.key,
    required this.request,
  });

  Request request;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.requestInfo);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 110,
            child: Center(
              child: Text(
                request.solicitudId,
                style: TextStyles.h4,
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: Center(
              child: Text(
                request.tipoSolicitudDescripcion,
                style: TextStyles.h4,
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Center(
              child: Text(
                request.nombre,
                style: TextStyles.h4,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Center(
              child: Text(
                request.nombreEmpleadoEncargado,
                style: TextStyles.h4,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Container(
              width: 180,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: getColorFromStatus(request.estadoDescripcion),
              ),
              child: Center(
                child: Text(
                  request.estadoDescripcion,
                  style: TextStyles.h5,
                ),
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
                  toolTip: 'Procesar',
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
    );
  }

  Color getColorFromStatus(String status) {
    final Map<String, Color> statusColors = {
      'FINALIZADO SIN EXITO': Colors.red,
      'NUEVA': Colors.blue,
      'EN PROCESO': Colors.amber,
      'FINALIZADA CON EXITO': Colors.green,
    };

    return statusColors[status] ?? Colors.black;
  }
}
