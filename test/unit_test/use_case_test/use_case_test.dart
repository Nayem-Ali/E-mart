import 'package:dio/dio.dart';
import 'package:e_mart/src/core/network/dio_client.dart';
import 'package:e_mart/src/features/products/data/data_soruce/remote/product_remote_data_source.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_all_products_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_categorized_product_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/search_product_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../utils/mocks/mock_product.dart';

void main() {
  late DioClient dioClient; // Use a different name to avoid confusion
  late ProductRemoteDataSource dataSource;
  late ProductRepositoryImpl mockProductRepositoryImpl;
  late FetchAllProductsUseCase fetchAllProductsUseCase;
  late FetchCategorizedProductUseCase fetchCategorizedProductUseCase;
  late SearchProductUseCase searchProductUseCase;
  late ProductDto productDto;
  late List<Product> mockProductsList;
  late Product mockProduct;

  setUp(() {
    dioClient = DioClient(Dio());
    dataSource = ProductRemoteDataSource(dioClient: dioClient);
    mockProductRepositoryImpl = ProductRepositoryImpl(dataSource: dataSource);
    productDto = ProductDto(limit: 1, skip: 0);
    mockProductsList = products;
    mockProduct = product;
    fetchAllProductsUseCase = FetchAllProductsUseCase(repositoryImpl: mockProductRepositoryImpl);
    searchProductUseCase = SearchProductUseCase(repositoryImpl: mockProductRepositoryImpl);
    fetchCategorizedProductUseCase = FetchCategorizedProductUseCase(
      repositoryImpl: mockProductRepositoryImpl,
    );
  });

  test("Fetch Product Use Case should return list of product from repository", () async {
    List<Product> response = await fetchAllProductsUseCase.call(productDto);
    expect(response, mockProductsList);
  });

  test(
    "Search Product Use Case should return list of product from repository",
    () async {
      List<Product> response = await searchProductUseCase.call(mockProduct.title);
      expect(response, mockProductsList);
    },
  );

  test(
    "Fetch Categorized Product Use Case should return list of product from repository",
        () async {
      List<Product> response = await fetchCategorizedProductUseCase.call(mockProduct.category);
      expect(response.first.id, mockProductsList.first.id);
    },
  );
}
