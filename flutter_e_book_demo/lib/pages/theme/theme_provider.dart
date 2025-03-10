import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/pages/theme/dart_theme.dart';
import 'package:flutter_e_book_demo/pages/theme/light_theme.dart';

///主题颜色设置
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;
  ThemeData get lightData => lightMode;
  ThemeData get dartTheme => dartMode;

  bool get isDartMode => _themeData == dartMode;

  //设置亮色或者暗夜主题
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  /// 切换主题
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = dartMode;
    } else {
      themeData = lightMode;
    }
  }
}
