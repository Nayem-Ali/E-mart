import 'package:e_mart/src/core/database/hive/hive_db_config.dart';
import 'package:e_mart/src/core/dl/dependency_injection.dart';
import 'package:e_mart/src/core/utils/logger/logger.dart';
import 'package:e_mart/src/features/products/data/model/product.dart';
import 'package:hive/hive.dart';

class FavouriteProductDao {
  final Box _favouriteBox = sl.get<HiveDbConfig>().getFavouriteBox;

  Future<void> addToFavourite({required Product product}) async {
    try {
      await _favouriteBox.put(product.id, product.title);
    } catch (e) {
      debug(e);
    }
  }

  Future<void> removeFromFavourite({required Product product}) async {
    try {
      await _favouriteBox.delete(product.id);
    } catch (e) {
      debug(e);
    }
  }

  bool checkFavourite({required Product product}) {
    try {
      return _favouriteBox.containsKey(product.id);
    } catch (e) {
      debug(e);
    }
    return false;
  }
}
