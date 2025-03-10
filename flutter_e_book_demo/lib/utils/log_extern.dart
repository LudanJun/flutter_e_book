import 'package:flutter/foundation.dart';

void AALog(Object log, {bool showLine = true}) {
  if (kDebugMode) {
    if (showLine) {
      JDCustomTrace programInfo = JDCustomTrace(StackTrace.current);
      print("[${programInfo.fileName} line:${programInfo.lineNumber}] $log");
    } else {
      print("$log");
    }
  }
}

class JDCustomTrace {
  final StackTrace? _trace;

  String fileName = '';
  int lineNumber = 0;

  JDCustomTrace(this._trace) {
    _parseTrace();
  }

  void _parseTrace() {
    var traceString = _trace.toString().split("\n")[1];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    List listOfInfo = fileInfo.split(":");
    if (listOfInfo.length >= 2) {
      fileName = listOfInfo[0];
      lineNumber = int.parse(listOfInfo[1]);
    }
  }
}
