import 'package:dio/dio.dart';

import 'api_endpoints.dart';
import 'cache_interceptor.dart';

class DioClient {
  static const commonHeader = {"Content-Type": "application/json", "accept": "application/json"};

  final Dio dio;

  DioClient(this.dio) {
    dio.options = BaseOptions(baseUrl: ApiEndpoints.baseUrl, headers: commonHeader);
    // ..interceptors.add(CachingInterceptor());
  }
}
