import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/base/utils/shared_preference.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  late RxInt level;
  late SharedPrefs _sharedPrefs;

  @override
  void onInit() {
    super.onInit();
    _sharedPrefs = getIt<SharedPrefs>();
    level = (_sharedPrefs.getInt("level") ?? 1).obs;
  }

  void updateLevel() {
    level.value++;
    level.refresh();
    int savedLevel = _sharedPrefs.getInt("level") ?? 1;
    if (level.value > savedLevel) {
      _sharedPrefs.putInt("level", level.value);
    }
  }

  @override
  void dispose() {
    super.dispose();
    level.close();
  }
}
