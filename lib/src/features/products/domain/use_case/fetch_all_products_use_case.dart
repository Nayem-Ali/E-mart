import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
import 'package:e_mart/src/features/products/domain/repository/product_repository.dart';
import 'package:e_mart/src/features/shared/domain/use_case/base_use_case.dart';

class FetchAllProductsUseCase extends UseCase<List<Product>, ProductDto> {
  ProductRepository repositoryImpl;

  FetchAllProductsUseCase({required this.repositoryImpl});

  @override
  Future<List<Product>> call(ProductDto productDto) async {
    return await repositoryImpl.fetchAllProducts(productDto: productDto);
  }
}
