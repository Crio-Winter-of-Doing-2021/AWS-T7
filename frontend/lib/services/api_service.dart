import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/utils/app_logger.dart';
import 'package:frontend/utils/global.dart';
import 'package:frontend/utils/helper.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  Dio _dio;

  ApiService() {
    final options = BaseOptions(
      baseUrl: Global.baseUrl,
      connectTimeout: 90000,
      receiveTimeout: 90000,
      sendTimeout: 90000,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    _dio = new Dio(options);

    addErrorHandler();
  }

  Dio getClient() {
    return _dio;
  }

  void addErrorHandler() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (Response response) async {
          AppLogger.print(response.toString());
          return response;
        },
        onError: _errorHandler,
      ),
    );
  }

  Future<Response<dynamic>> _errorHandler(DioError dioError) async {
    AppLogger.print(dioError);
    String message;
    if (dioError.type == DioErrorType.RESPONSE) {
      final data = dioError.response.data;

      if (dioError.response.statusCode == 400) {
        message = "Some error occured";
      } else if (dioError.response.statusCode == 403) {
        message =
            data['error'] != null ? data['error'].toString() : "Forbidden";
        message = "Not found";
      } else if (dioError.response.statusCode == 405) {
        message = "Route does not exist";
      } else if (dioError.response.statusCode == 500) {
        message = data['error'].toString();
      } else {
        message = "Something went wrong";
      }
    } else if (dioError.type == DioErrorType.CONNECT_TIMEOUT) {
      message = "connection timedout";
    } else if (dioError.type == DioErrorType.DEFAULT) {
      if (dioError.message.contains('SocketException')) {
        message = "Please check your internet connection";
      }
    }

    Helper.showToast(message, false);

    return dioError.response;
  }
}
