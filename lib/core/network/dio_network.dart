

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../helper/helper.dart';
import '../utils/constant.dart';
import '../utils/log/app_logger.dart';
import 'logger_interceptor.dart';

class DioNetwork {

  static late Dio dio;

  static void initDio() {
    dio = Dio(baseOptions(Constant.baseUrl));
    dio.interceptors.add(loggerInterceptor());
  }

  static LoggerInterceptor loggerInterceptor() {
    return LoggerInterceptor(
      logger,
      request: true,
      requestBody: kDebugMode ? false : true,
      error: true,
      responseBody: kDebugMode ? false : true,
      responseHeader: false,
      requestHeader: true,
    );
  }

  static BaseOptions baseOptions(String url) {
    // Map<String, dynamic> headers = Helper.getHeaders();

    return BaseOptions(
        baseUrl: url,
        validateStatus: (s) {
          return s! < 300;
        },
        // headers: headers..removeWhere((key, value) => value == null),
        responseType: ResponseType.json,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000)
    );
  }
}