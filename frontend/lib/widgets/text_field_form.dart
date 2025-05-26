import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TextFieldForm extends StatelessWidget {
  TextFieldForm({
    super.key,
    this.focusNode,
    required this.width,
    required this.controller,
    required this.icon,
    required this.label,
    this.passwordText = false,
    this.length,
    this.lines,
    this.viewButton = false,
    this.autocorrect = false,
    this.suggestions = false,
    this.enabled,
    this.keyboardType = TextInputType.text,
    this.onEditingComplete,
    required this.validator,
  });

  final FocusNode? focusNode;
  final double width;
  final TextEditingController controller;
  final IconData icon;
  final String label;
  bool passwordText;
  final int? length;
  final int? lines;
  final bool viewButton;
  final bool? enabled;
  final bool autocorrect;
  final bool suggestions;
  final TextInputType keyboardType;
  final void Function()? onEditingComplete;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    RxBool hasError = false.obs;
    RxBool isPasswordText = passwordText.obs;

    return SizedBox(
      width: width,
      child: Obx(
        () => TextFormField(
          autocorrect: autocorrect,
          enableSuggestions: suggestions,
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPasswordText.value,
          maxLength: length,
          maxLines: lines,
          enabled: enabled,
          decoration: InputDecoration(
            label: !hasError.value
                ? Text(
                    label,
                    style: const TextStyle(color: Color(0xFF466B73)),
                  )
                : Text(
                    label,
                    style: const TextStyle(color: Colors.red),
                  ),
            prefixIcon: Icon(
              icon,
              fill: BorderSide.strokeAlignCenter,
            ),
            suffixIcon: viewButton
                ? IconButton(
                    onPressed: () {
                      isPasswordText.value = !isPasswordText.value;
                    },
                    icon: Icon(isPasswordText.value
                        ? Icons.remove_red_eye
                        : Icons.visibility_off),
                  )
                : null,
          ),
          validator: (value) {
            String? error = validator(value);
            hasError.value = error != null;
            return error;
          },
          onChanged: (value) {
            onEditingComplete;
          },
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
