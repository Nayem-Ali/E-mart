import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/features/products/data/model/category.dart';
import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
import 'package:e_mart/src/features/products/domain/repository/product_repository.dart';
import 'package:e_mart/src/features/shared/domain/use_case/base_use_case.dart';

class FetchAllCategoriesUseCase extends UseCase<List<CategoryModel>, NoParams> {
  final ProductRepository _repositoryImpl = sl.get<ProductRepositoryImpl>();

  @override
  Future<List<CategoryModel>> call(NoParams noParams) async {
    return await _repositoryImpl.fetchAllCategories();
  }
}