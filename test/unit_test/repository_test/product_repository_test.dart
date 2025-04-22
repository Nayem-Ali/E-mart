// // import 'package:e_mart/src/features/products/data/data_soruce/remote/product_remote_data_source.dart';
// // import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
// // import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:mockito/annotations.dart';
// // import 'package:mockito/mockito.dart';
// // import '../mocks/product.dart';
// // import 'product_repository_test.mocks.dart';
// //
// // @GenerateMocks([ProductRemoteDataSource, ProductRepositoryImpl])
// // void main() async {
// //   final productDataSource = MockProductRemoteDataSource();
// //   final mockProductRepositoryImpl = MockProductRepositoryImpl();
// //
// //   final ProductDto productDto = ProductDto(limit: 1, skip: 0);
// //
// //   void setUpData() {
// //     when(
// //       productDataSource.fetchAllProducts(limit: productDto.limit, skip: productDto.skip),
// //     ).thenAnswer((realInvocation) async => products);
// //   }
// //
// //   ;
// //   test("Checking Product Repo", () async {
// //     setUpData();
// //     final response = await mockProductRepositoryImpl.fetchAllProducts(
// //       productDto: productDto,
// //     );
// //     expect(response, products);
// //   });
// // }
//
// import 'package:e_mart/src/core/dl/dependency_injection.dart';
// import 'package:e_mart/src/core/network/dio_client.dart';
// import 'package:e_mart/src/features/products/data/data_soruce/remote/product_remote_data_source.dart';
// import 'package:e_mart/src/features/products/data/model/product.dart';
// import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
// import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import '../mocks/product.dart';
//
// @GenerateMocks([ProductRemoteDataSource]) // Only mock the data source
// void main() {
//   late ProductRepositoryImpl repository;
//   late MockProductRemoteDataSource mockDataSource;
//   late ProductDto productDto;
//   late List<Product> mockProducts;
//   late Product mockProduct;
//
//   setUp(() {
//     mockDataSource = MockProductRemoteDataSource();
//     repository = ProductRepositoryImpl(dataSource: mockDataSource);
//     productDto = ProductDto(limit: 1, skip: 0);
//     mockProducts = products;
//     mockProduct = product;
//   });
//
//   test("fetchAllProducts() should return products from data source", () async {
//     when(mockDataSource.fetchAllProducts(limit: 1, skip: 0)).thenAnswer((_) async => products);
//
//     final response = await repository.fetchAllProducts(productDto: productDto);
//
//     expect(response, mockProducts);
//     verify(mockDataSource.fetchAllProducts(limit: 1, skip: 0)).called(1);
//   });
//
//   test("fetchAllProducts() should return products from data source", () async {
//     when(
//       mockDataSource.fetchAllProductsByCategory(categoryName: mockProduct.category),
//     ).thenAnswer((_) async => mockProducts);
//
//     final response = await repository.fetchProductsByCategory(categoryName: mockProduct.category);
//
//     expect(response, products);
//     verify(mockDataSource.fetchProductsByCategory(categoryName: mockProduct.category).called(1);
//   });
// }
