import 'package:dio/dio.dart';
import 'package:flutter_e_book_demo/utils/log_utils.dart';

// 定义打印拦截器,方便调试
// 拦截包装器扩展
class PrintLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //打印请求信息,方便调试
    LogUtils.println("\nonRequest------------->");
    options.headers.forEach((key, value) {
      LogUtils.println("headers: key=$key  value=${value.toString()}");
    });
    LogUtils.println("path: ${options.uri}");
    LogUtils.println("method: ${options.method}");
    LogUtils.println("data: ${options.data}");
    LogUtils.println("queryParameters: ${options.queryParameters.toString()}");
    LogUtils.println("<-------------onRequest\n");
    super.onRequest(options, handler);
  }

  // 请求的 html 很长,这里注释响应结果打印
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   LogUtils.println("\nonResponse------------->");
  //   LogUtils.println("path: ${response.realUri}");
  //   LogUtils.println("headers: ${response.headers.toString()}");
  //   LogUtils.println("statusMessage: ${response.statusMessage}");
  //   LogUtils.println("statusCode: ${response.statusCode}");
  //   LogUtils.println("extra: ${response.extra.toString()}");
  //   LogUtils.println("data: ${response.data}");
  //   LogUtils.println("<-------------onResponseln");
  //   super.onResponse(response, handler);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LogUtils.println("\nonError------------->");
    LogUtils.println("error: ${err.toString()}");
    LogUtils.println("<-------------onError\n");
    super.onError(err, handler);
  }
}
