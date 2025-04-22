import 'package:dio/dio.dart';
import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/core/network/api_endpoints.dart';
import 'package:e_mart/src/core/network/dio_client.dart';
import 'package:e_mart/src/core/utils/logger/logger.dart';
import 'package:e_mart/src/features/products/data/model/category.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';

class ProductRemoteDataSource {
  DioClient dioClient = sl.get<DioClient>();

  Future<List<Product>> fetchAllProducts({required int limit, required int skip}) async {
    List<Product> allProducts = [];
    final Map<String, dynamic> queryParameters = {"limit": limit, "skip": skip};
    try {
      final Response response = await dioClient.dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.fetchProduct}",
        queryParameters: queryParameters,
      );
      int statusCode = response.statusCode ?? 400;
      if (statusCode >= 200 && statusCode < 300) {
        allProducts =
            (response.data['products'] as List<dynamic>)
                .map((product) => Product.fromJson(product as Map<String, dynamic>))
                .toList();
      } else {
        debug(response.statusMessage ?? "Something went wrong!");
      }
    } catch (e) {
      debug(e);
    }
    return allProducts;
  }

  Future<List<CategoryModel>> fetchAllCategories() async {
    List<CategoryModel> allCategory = [];

    try {
      final Response response = await dioClient.dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.fetchCategory}",
      );
      int statusCode = response.statusCode ?? 400;
      if (statusCode >= 200 && statusCode < 300) {
        allCategory =
            (response.data as List<dynamic>)
                .map((category) => CategoryModel.fromJson(category as Map<String, dynamic>))
                .toList();
      } else {
        debug(response.statusMessage ?? "Something went wrong!");
      }
    } catch (e) {
      debug(e);
    }
    return allCategory;
  }

  Future<List<Product>> fetchAllProductsByCategory({required String categoryName}) async {
    List<Product> allProducts = [];

    try {
      final Response response = await dioClient.dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.categorizedProduct}/$categoryName",
      );
      int statusCode = response.statusCode ?? 400;
      if (statusCode >= 200 && statusCode < 300) {
        allProducts =
            (response.data['products'] as List<dynamic>)
                .map((product) => Product.fromJson(product as Map<String, dynamic>))
                .toList();
      } else {
        debug(response.statusMessage ?? "Something went wrong!");
      }
    } catch (e) {
      debug(e);
    }
    return allProducts;
  }

  Future<List<Product>> searchProduct({required String query}) async {
    List<Product> allProducts = [];
    final Map<String, dynamic> queryParameters = {"q": query};
    try {
      final Response response = await dioClient.dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.searchProduct}",
        queryParameters: queryParameters,
      );
      int statusCode = response.statusCode ?? 400;
      if (statusCode >= 200 && statusCode < 300) {
        allProducts =
            (response.data['products'] as List<dynamic>)
                .map((product) => Product.fromJson(product as Map<String, dynamic>))
                .toList();
      } else {
        debug(response.statusMessage ?? "Something went wrong!");
      }
    } catch (e) {
      debug(e);
    }
    return allProducts;
  }
}
