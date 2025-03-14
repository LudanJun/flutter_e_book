import 'package:flutter/material.dart';

///暗色主题适配
ThemeData dartMode = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0.0,
  ),
  colorScheme: ColorScheme.dark(
    primary: const Color(0xFF3CA9FC),
    onPrimary: Colors.white,
    secondary: const Color(0xFFA8C1D2).withOpacity(0.25),
    tertiary: const Color(0xFFEE4667),
    inversePrimary: Colors.grey.shade600,
    inverseSurface: Colors.black87,
    onInverseSurface: Colors.black26,
    surface: Colors.black87, //这个颜色是主题颜色可以亮色深色改变 // Colors.grey.shade300,
    // surfaceTint: const Color(0xFFEE4667), // Colors.grey.shade300,
  ),
);
