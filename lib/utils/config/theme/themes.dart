import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  useMaterial3: false,
  fontFamily: 'Lato',
  brightness: Brightness.light,
  primaryColor: mainColors,
  colorScheme: ColorScheme.fromSeed(seedColor: mainColors),
  scaffoldBackgroundColor: bgColors,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: mainColors,
  ),
);

const Color mainColors = Color(0xFF373fa1);
const Color secondColors = Color(0xFF4e9af0);
const Color thirdColors = Color(0xFFec2029);
const Color bgColors = Color(0xFFF5F5F5);
const Color bgBoxColors = Color(0xFFebebeb);

FontWeight light = FontWeight.w300;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
