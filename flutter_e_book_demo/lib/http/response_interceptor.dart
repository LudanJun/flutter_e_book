import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_book_demo/utils/toast_utils.dart';

// 定义响应拦截器,处理错误
class ResponseInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage = "请检查网络";
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      errorMessage = "链接超时,请检查网络链接";
    } else if (err.type == DioExceptionType.receiveTimeout) {
      errorMessage = "服务器响应超时,请稍后重试";
    } else if (err.response?.statusCode == 404) {
      errorMessage = "请求的资源不存在";
    } else if (err.type == DioExceptionType.unknown) {
      errorMessage = "未知错误,请重试";
    }
    debugPrint(errorMessage);
    // 显示错误信息
    ToastUtils.showErrorMsg(errorMessage);
    // 使用handler.next继续传递错误
    return handler.next(err);
  }
}
