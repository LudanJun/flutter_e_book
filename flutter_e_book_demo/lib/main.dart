 import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/app.dart';
import 'package:flutter_e_book_demo/pages/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
