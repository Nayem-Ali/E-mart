import 'package:hive_flutter/adapters.dart';

class HiveDbConfig {
  static const String _productBox = "productBox";
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_productBox);
  }

  Box get getProductBox => Hive.box(_productBox);
}
