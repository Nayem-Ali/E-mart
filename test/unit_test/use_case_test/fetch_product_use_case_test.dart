import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_all_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../mocks/product.dart';
import 'fetch_product_use_case_test.mocks.dart';


@GenerateMocks([ProductRepositoryImpl])
void main() async {
  await setupService();
  late MockProductRepositoryImpl repositoryImpl;
  late FetchAllProductsUseCase useCase;
  late ProductDto productDto;
  late List<Product> mockProducts;

  setUp(() {
    repositoryImpl = MockProductRepositoryImpl();
    useCase = FetchAllProductsUseCase(repositoryImpl: repositoryImpl);
    productDto = ProductDto(limit: 1, skip: 0);
    mockProducts = products;
  });

  test("Fetch Product Use Case should return list of product", () async {

    // Arrange
    when(
      repositoryImpl.fetchAllProducts(productDto: productDto),
    ).thenAnswer((invocation) async => mockProducts);

    // Act
    List<Product> response = await useCase.call(productDto);

    expect(response, products);
  });

  test("Fetch Product Use Case should return empty list", () async {
    when(
      repositoryImpl.fetchAllProducts(productDto: productDto),
    ).thenAnswer((invocation) async => []);

    productDto.limit = 0;
    List<Product> response = await useCase.call(productDto);

    expect(response, []);
  });
}
