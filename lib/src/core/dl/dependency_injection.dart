import 'package:dio/dio.dart';
import 'package:e_mart/src/core/database/hive/dao/favourite_product_dao.dart';
import 'package:e_mart/src/core/database/hive/hive_db_config.dart';
import 'package:e_mart/src/core/network/dio_client.dart';
import 'package:e_mart/src/features/products/data/repository/products_repository_impl.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_all_categories_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_all_products_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/fetch_categorized_product_use_case.dart';
import 'package:e_mart/src/features/products/domain/use_case/search_product_use_case.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.I;

Future<void> setupService() async {
  sl.registerSingletonAsync<HiveDbConfig>(() async {
    HiveDbConfig hiveDbConfig = HiveDbConfig();
    await hiveDbConfig.init();
    return hiveDbConfig;
  });
  await sl.isReady<HiveDbConfig>();
  sl.registerSingleton<DioClient>(DioClient(Dio()));
  // sl.registerSingleton<ProductRepositoryImpl>(ProductRepositoryImpl());
  // sl.registerSingleton<FetchAllProductsUseCase>(FetchAllProductsUseCase());
  // sl.registerSingleton<FetchAllCategoriesUseCase>(FetchAllCategoriesUseCase());
  // sl.registerSingleton<FetchCategorizedProductUseCase>(FetchCategorizedProductUseCase());
  // sl.registerSingleton<SearchProductUseCase>(SearchProductUseCase());
  sl.registerSingleton<FavouriteProductDao>(FavouriteProductDao());
  await sl.allReady();
}
