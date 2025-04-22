import 'package:dio/dio.dart';
import 'package:e_mart/src/core/database/hive/hive_db_config.dart';
import 'package:e_mart/src/core/network/dio_client.dart';
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
  await sl.allReady();
}
