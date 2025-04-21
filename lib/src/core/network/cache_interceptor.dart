import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:e_mart/src/core/database/hive/dao/network_response_dao.dart';
import 'package:e_mart/src/core/utils/logger/logger.dart';

class CachingInterceptor extends InterceptorsWrapper {
  final NetworkResponseDao _networkResponseDao = NetworkResponseDao();


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    int statusCode = response.statusCode ?? 500;
    if (statusCode >= 200 && statusCode < 300) {
      String responseData = jsonEncode(response.data);
      _networkResponseDao.addResponseData(
        key: response.requestOptions.uri.toString(),
        value: responseData,
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debug("error data: ${err.type}");
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      Response? response = await _networkResponseDao.getResponseData(
        key: err.requestOptions.uri.toString(),
        err: err,
      );
      debug("error data: $response");
      if (response != null) {
        handler.resolve(response);
        return;
      }
    }
    super.onError(err, handler);
  }
}
