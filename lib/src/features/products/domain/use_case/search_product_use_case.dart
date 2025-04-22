import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
import 'package:e_mart/src/features/products/domain/repository/product_repository.dart';
import 'package:e_mart/src/features/shared/domain/use_case/base_use_case.dart';

class SearchProductUseCase extends UseCase<List<Product>, String> {
  // final ProductRepository _repositoryImpl = sl.get<ProductRepositoryImpl>();

  final ProductRepository repositoryImpl;

  SearchProductUseCase({required this.repositoryImpl});

  @override
  Future<List<Product>> call(String query) async {
    return await repositoryImpl.searchProducts(query: query);
  }


}
