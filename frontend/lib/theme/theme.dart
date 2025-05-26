import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: const Color(0xFF68CDEC),
    secondary: Colors.blue[50]!,
  ),
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 300,
    backgroundColor: Colors.white38,
    surfaceTintColor: Color(0xFFF2F2F2),
    titleTextStyle: TextStyle(
      color: Color(0xFF3E5C67),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Color(0xFF3E5C67)),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.white,
    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    unselectedLabelColor: Colors.white,
    unselectedLabelStyle: TextStyle(fontSize: 14),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Color(0xFF3E5C67)),
    displayMedium: TextStyle(color: Color(0xFF68CDEC)),
    displaySmall: TextStyle(color: Color(0xFF68CDEC)),
    titleLarge: TextStyle(color: Color(0xFF3E5C67)),
    titleMedium: TextStyle(color: Color(0xFF68CDEC)),
    titleSmall: TextStyle(color: Color(0xFF68CDEC)),
    bodyLarge: TextStyle(color: Color(0xFF3E5C67)),
    bodyMedium: TextStyle(color: Color(0xFF3E5C67)),
    bodySmall: TextStyle(color: Color(0xFF68CDEC)),
    headlineLarge: TextStyle(color: Color(0xFF68CDEC)),
    headlineMedium: TextStyle(color: Color(0xFF68CDEC)),
    headlineSmall: TextStyle(color: Color(0xFF68CDEC)),
    labelLarge: TextStyle(color: Color(0xFF3E5C67), fontSize: 17),
    labelMedium: TextStyle(color: Color(0xFF68CDEC)),
    labelSmall: TextStyle(color: Color(0xFF68CDEC)),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    modalBackgroundColor: Colors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.grey[100],
    surfaceTintColor: Colors.transparent,
  ),
  iconTheme: const IconThemeData(color: Color(0xFF3E5C67)),
  listTileTheme: const ListTileThemeData(iconColor: Colors.blue),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF68CDEC),
      foregroundColor: Colors.white,
      shadowColor: const Color(0xFFF2F2F2),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF91D97E),
      foregroundColor: Colors.white,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
    labelTextStyle: MaterialStatePropertyAll(
      TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
    ),
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF466B73)),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF466B73)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF68CDEC)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
    errorStyle: TextStyle(color: Colors.red),
    labelStyle: TextStyle(color: Color(0xFF68CDEC)),
    floatingLabelStyle: TextStyle(color: Color(0xFF68CDEC)),
    prefixIconColor: Color(0xFF68CDEC),
    suffixIconColor: Color(0xFF68CDEC),
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: const TextStyle(color: Colors.black),
    backgroundColor: Colors.blue[50],
  ),
);
