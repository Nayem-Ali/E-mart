import 'package:e_mart/src/features/products/data/data_soruce/remote/product_remote_data_source.dart';
import 'package:e_mart/src/features/products/data/model/category.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
import 'package:e_mart/src/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  // final ProductRemoteDataSource _dataSource = ProductRemoteDataSource();

  final ProductRemoteDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<List<Product>> fetchAllProducts({required ProductDto productDto}) async {
    List<Product> allProducts = await dataSource.fetchAllProducts(
      limit: productDto.limit,
      skip: productDto.skip,
    );
    return allProducts;
  }

  @override
  Future<List<CategoryModel>> fetchAllCategories() async {
    List<CategoryModel> allCategories = await dataSource.fetchAllCategories();
    return allCategories;
  }

  @override
  Future<List<Product>> fetchProductsByCategory({required String categoryName}) async {
    List<Product> allProducts = await dataSource.fetchAllProductsByCategory(
      categoryName: categoryName,
    );
    return allProducts;
  }

  @override
  Future<List<Product>> searchProducts({required String query}) async {
    List<Product> allProducts = await dataSource.searchProduct(query: query);
    return allProducts;
  }
}
