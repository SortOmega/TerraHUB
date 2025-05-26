import 'package:flutter/material.dart';

class TextStyles {
  static const inkButtonsText = TextStyle(
      color: Color(0xFF3E5C67), fontSize: 17, fontWeight: FontWeight.w500);

  static const appBarTitle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);

  static const productTitleMobile =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  static const footer = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  static const h1 =
      TextStyle(fontSize: 90, fontWeight: FontWeight.bold, shadows: [
    Shadow(
      color: Colors.white,
      offset: Offset(3, 3),
      blurRadius: 17,
    ),
  ]);

  static const h2 = TextStyle(fontSize: 50, fontWeight: FontWeight.bold);

  static const h3 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const h4 = TextStyle(fontSize: 18);

  static const h5 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
}
