import 'package:hive_flutter/adapters.dart';

class HiveDbConfig {
  static const String _productBox = "productBox";
  static const String _favouriteBox = "favouriteBox";
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_productBox);
    await Hive.openBox(_favouriteBox);
  }

  Box get getProductBox => Hive.box(_productBox);
  Box get getFavouriteBox => Hive.box(_favouriteBox);
}
