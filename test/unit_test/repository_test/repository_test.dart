import 'package:dio/dio.dart';
import 'package:e_mart/src/core/network/dio_client.dart';
import 'package:e_mart/src/features/products/data/data_soruce/remote/product_remote_data_source.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../utils/mocks/mock_product.dart';

void main() {
  late DioClient dioClient;
  late ProductRemoteDataSource dataSource;
  late ProductRepositoryImpl productRepositoryImpl;
  late ProductDto productDto;
  late Product mockProduct;
  late List<Product> mockProductsList;

  setUp(() {
    dioClient = DioClient(Dio());
    dataSource = ProductRemoteDataSource(dioClient: dioClient);
    productRepositoryImpl = ProductRepositoryImpl(dataSource: dataSource);
    productDto = ProductDto(limit: 1, skip: 0);
    mockProduct = product;
    mockProductsList = products;
  });

  test("Fetching All Product from Product Repository", () async {
    List<Product> response = await productRepositoryImpl.fetchAllProducts(productDto: productDto);
    expect(response, mockProductsList);
  });

  test("Searching Product from Product Repository", () async {
    List<Product> response = await productRepositoryImpl.searchProducts(query: mockProduct.title);
    expect(response, mockProductsList);
  });

  test("Fetching Categorized Product from Product Repository", () async {
    List<Product> response = await productRepositoryImpl.fetchProductsByCategory(
      categoryName: mockProduct.category,
    );
    expect(response.first.title, mockProductsList.first.title);
  });
}
