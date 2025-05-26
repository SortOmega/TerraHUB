import 'package:flutter/material.dart';
import 'package:terrahub/styles/text_styles.dart';
import 'package:terrahub/widgets/ink_buttons.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkButton(
      onPressed: onPressed,
      hoverColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              label,
              style: TextStyles.h3,
            )
          ],
        ),
      ),
    );
  }
}
