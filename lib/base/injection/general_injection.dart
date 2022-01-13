import 'package:brick_breaker_game/base/utils/shared_preference.dart';
import 'package:brick_breaker_game/controller/game_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initGeneralInjection() async {
  getIt.registerSingletonAsync<SharedPrefs>(() async {
    final sharedPrefs = SharedPrefs();
    await sharedPrefs.init();
    return sharedPrefs;
  });
  await GetIt.instance.isReady<SharedPrefs>().then((_) async {
    getIt.registerFactory<MainController>(() => MainController());
  });
}
