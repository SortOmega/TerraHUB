import 'package:flutter/material.dart';

class InkButton extends StatelessWidget {
  const InkButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.bordeRadius = 18,
    this.toolTip = '',
  });

  final void Function() onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color hoverColor;
  final double bordeRadius;
  final String toolTip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(bordeRadius),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: hoverColor,
      onTap: onPressed,
      child: Tooltip(
        message: toolTip,
        margin: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(bordeRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: child,
          ),
        ),
      ),
    );
  }
}
