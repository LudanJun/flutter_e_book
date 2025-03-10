// 稍微封装一下打印方法

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_e_book_demo/utils/log_extern.dart';

class LogUtils {
  static bool isOpenLog = kDebugMode;

  static void println(String obj) {
    if (isOpenLog) debugPrint(obj);
  }

  static void logger(String obj, {int level = 0}) {
    if (isOpenLog) {
      JDCustomTrace programInfo = JDCustomTrace(StackTrace.current);
      log(
        "[${programInfo.fileName} line:${programInfo.lineNumber}] $obj",
        stackTrace: StackTrace.current,
        level: level,
      );
    }
  }
}
