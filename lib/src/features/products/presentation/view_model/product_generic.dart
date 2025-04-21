import 'package:e_mart/src/features/products/data/model/category.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';

class ProductGeneric {
  int limit = 10;
  int? skip;
  List<Product>? products;
  List<CategoryModel>? categories;
  bool? doesSearching;
  bool? doesLoading;

  ProductGeneric({
    this.products = const [],
    this.categories = const [],
    this.skip = 0,
    this.doesSearching = false,
    this.doesLoading = false,
  });

  ProductGeneric update({
    int? skip,
    List<Product>? products,
    List<CategoryModel>? categories,
    bool? doesSearching,
    bool? doesLoading,
  }) {
    return ProductGeneric(
      skip: skip ?? this.skip,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      doesSearching: doesSearching ?? this.doesSearching,
      doesLoading: doesLoading ?? this.doesLoading,
    );
  }
}
