import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/http/dio_instance.dart';
import 'package:flutter_e_book_demo/pages/root/root_page.dart';
import 'package:flutter_e_book_demo/pages/theme/dart_theme.dart';
import 'package:flutter_e_book_demo/pages/theme/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Size get designSize {
  final firstView = WidgetsBinding.instance.platformDispatcher.views.first;
  //逻辑短边
  final logicalShortestSize =
      firstView.physicalSize.shortestSide / firstView.devicePixelRatio;
  //逻辑长边
  final logicalLongestSize =
      firstView.physicalSize.longestSide / firstView.devicePixelRatio;
  //缩放比例
  const scaleFactor = 0.95;
  return Size(
      logicalShortestSize * scaleFactor, logicalLongestSize * scaleFactor);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //调用 initDio 方法初始化
    DioInstance.instance().initDio();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: designSize,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context, listen: true).themeData,
          //dartModes属性为跟随系统
          darkTheme: dartMode,
          home: const RootPage(),
        );
      },
    );
  }
}
