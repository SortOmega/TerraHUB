import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ButtonDropDown extends StatelessWidget {
  final String label;
  RxString selectedValue;
  final List<String> options;
  final IconData? icon;
  final double width;
  // ignore: prefer_typing_uninitialized_variables
  final content;

  void Function(dynamic)? onChanged;

  ButtonDropDown({
    super.key,
    required this.width,
    required this.label,
    required this.selectedValue,
    required this.options,
    this.icon,
    this.content,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(label),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[600]!,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: width,
          height: 70,
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      icon,
                      color: const Color(0xFF68CDEC),
                      size: 25,
                    ),
                  ),
                if (icon != null)
                  const SizedBox(
                    width: 8,
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: DropdownButton(
                      underline: null,
                      value: selectedValue.value,
                      isExpanded: true,
                      onChanged: (value) {
                        selectedValue.value = value!;
                        if (content != null) {
                          onChanged!(
                            content!.firstWhere((element) =>
                                element.propiedadId == selectedValue.value),
                          );
                        }
                      },
                      items: options.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(
                            option,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
