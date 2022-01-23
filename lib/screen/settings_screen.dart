import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:brick_breaker_game/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsController _settingsController;

  @override
  void initState() {
    super.initState();
    _settingsController = Get.put(getIt<SettingsController>());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppColors.blueLight, fontSize: 46),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () => _triggerAudio(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                        (_settingsController.audioState.value == true)
                            ? "Music    ON"
                            : "Music   OFF",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppColors.blueLight, fontSize: 46)),
                  ),
                  Obx(() => Icon(
                        (_settingsController.audioState.value == true)
                            ? Icons.music_note
                            : Icons.music_off,
                        color: AppColors.blueLight,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _triggerAudio() {
    _settingsController.saveAudioState(!_settingsController.isAudioEnabled());
  }
}
