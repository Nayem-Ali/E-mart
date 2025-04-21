import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:e_mart/src/features/products/domain/dto/product_dto.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_all_categories_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_all_products_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_categorized_product_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/search_product_use_case.dart';
import 'package:e_mart/src/features/products/presentation/view_model/product_generic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider = StateNotifierProvider<ProductController, ProductGeneric>(
  (ref) => ProductController(ref),
);

class ProductController extends StateNotifier<ProductGeneric> {
  ProductController(this.ref) : super(ProductGeneric());
  Ref ref;

  final FetchAllProductsUseCase _fetchAllProductsUseCase = sl.get<FetchAllProductsUseCase>();
  final FetchAllCategoriesUseCase _fetchAllCategoriesUseCase = sl.get<FetchAllCategoriesUseCase>();
  final SearchProductUseCase _searchProductUseCase = sl.get<SearchProductUseCase>();
  final FetchCategorizedProductUseCase _categorizedProductUseCase =
      sl.get<FetchCategorizedProductUseCase>();

  Future<void> fetchAllProducts() async {
    if (state.products!.isNotEmpty) {
      state.skip = state.products?.length ?? 0;
    }
    ProductDto productDto = ProductDto(limit: state.limit, skip: state.skip ?? 0);
    List<Product> products = await _fetchAllProductsUseCase.call(productDto);
    if(state.products!.isEmpty){
      state.products = products;
    }else{
      state.products?.addAll(products);
    }
    state = state.update(products: state.products);
  }
}
