import 'package:e_mart/src/features/products/data/model/product.dart';

class ProductGeneric {
  int limit = 10;
  int? skip;
  List<Product>? products;
  List<Product>? categorizedProducts;
  bool? doesSearching;
  bool? doesLoading;

  ProductGeneric({
    this.products = const [],
    this.categorizedProducts = const [],
    this.skip = 0,
    this.doesSearching = false,
    this.doesLoading = false,
  });

  ProductGeneric update({
    int? skip,
    List<Product>? products,
    List<Product>? categorizedProducts,
    bool? doesSearching,
    bool? doesLoading,
  }) {
    return ProductGeneric(
      skip: skip ?? this.skip,
      categorizedProducts: categorizedProducts ?? this.categorizedProducts,
      products: products ?? this.products,
      doesSearching: doesSearching ?? this.doesSearching,
      doesLoading: doesLoading ?? this.doesLoading,
    );
  }
}
