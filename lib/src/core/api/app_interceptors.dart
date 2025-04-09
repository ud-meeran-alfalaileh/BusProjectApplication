import 'package:dio/dio.dart';
import 'package:drive_app/src/core/user.dart';
import 'package:flutter/foundation.dart';
 
class AppIntercepters extends Interceptor {
  User user = User();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
