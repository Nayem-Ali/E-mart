import 'package:e_mart/src/features/products/data/model/category.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';

abstract class ProductRepository{
  Future<List<Product>> fetchAllProducts({required ProductDto productDto});
  Future<List<CategoryModel>> fetchAllCategories();
  Future<List<Product>> fetchProductsByCategory({required String categoryName});
  Future<List<Product>> searchProducts({required String query});
}