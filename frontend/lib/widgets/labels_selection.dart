import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/models/estate_model.dart';
import 'package:frontend/repositories/terrahub_api.dart';

// ignore: must_be_immutable
class LabelSelection extends StatelessWidget {
  LabelSelection({
    super.key,
    required this.selectedLabels,
    required this.controllersCant,
  });

  List<EtiquetaPropiedad> selectedLabels;
  List<TextEditingController> controllersCant;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Seleccionar Etiquetas'),
      children: [
        SizedBox(
          height: 310,
          width: 350,
          child: FutureBuilder(
            future: TerrahubAPI().getLabels(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        size: 64,
                        color: Colors.grey,
                      ),
                      Text(
                        'Aún no hay noticias',
                      ),
                    ],
                  ),
                );
              }
              List<EtiquetaPropiedad> availableLabels = snapshot.data!;
              List<String> selected = selectedLabels
                  .map((selected) => selected.nombreEtiqueta)
                  .toSet()
                  .toList();
              final List<RxBool> isSelectedList = List.generate(
                availableLabels.length,
                (index) => selected
                    .contains(availableLabels[index].nombreEtiqueta)
                    .obs,
              );
              return ListView.builder(
                shrinkWrap: true,
                itemCount: availableLabels.length,
                itemBuilder: (BuildContext context, int index) {
                  final label = availableLabels[index];
                  final isSelected = isSelectedList[index];
                  return ListTile(
                    title: Text(label.nombreEtiqueta),
                    trailing: Obx(
                      () => isSelected.value
                          ? const Icon(Icons.check_box)
                          : const Icon(Icons.check_box_outline_blank),
                    ),
                    onTap: () {
                      if (!isSelected.value) {
                        isSelected.toggle();
                        selectedLabels.add(label);

                        controllersCant.add(TextEditingController());
                      } else {
                        isSelected.toggle();
                        selectedLabels.removeWhere((element) =>
                            element.nombreEtiqueta == label.nombreEtiqueta);

                        controllersCant.removeLast();
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ),
      ],
    );
  }
}
