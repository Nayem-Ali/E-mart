import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_mart/src/core/database/hive/hive_db_config.dart';
import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/core/utils/logger/logger.dart';
import 'package:hive/hive.dart';

class NetworkResponseDao {
  final Box _productBox = sl.get<HiveDbConfig>().getProductBox;

  Future<void> addResponseData({required String key, required dynamic value}) async {
    try {
      await _productBox.put(key, value);
    } catch (e) {
      debug(e);
      rethrow;
    }
  }

  Future<Response?> getResponseData({required String key, required DioException err}) async {

    try {
      debug("Get RES Key $key");
      bool doesExist = _productBox.containsKey(key);
      if (doesExist) {
        final data = await _productBox.get(key);
        Response response = Response(requestOptions: err.requestOptions);
        response.statusCode = 200;
        response.data = jsonDecode(data.toString());
        return response;
      }
      else{
        debug("Not Exist");
      }
    } catch (e) {
      debug(e.toString());
      rethrow;
    }

    return null;
  }


}
