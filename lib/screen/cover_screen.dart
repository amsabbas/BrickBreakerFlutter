import 'package:brick_breaker_game/base/language/language.dart';
import 'package:brick_breaker_game/base/style/color_extension.dart';

import 'package:brick_breaker_game/base/widget/empty_app_bar.dart';
import 'package:brick_breaker_game/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'level_screen.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: Theme.of(context).cardColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              MessageKeys.brickBreakerTitleKey.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.mainColor, fontSize: 60),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.mainColor,
                    shape: BoxShape.circle)),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
                onTap: _startGame,
                child: Text(
                  MessageKeys.playButtonTitleKey.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.mainColor,
                      fontSize: 46),
                )),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
                onTap: _openSettings,
                child: Text(
                  MessageKeys.settingsButtonTitleKey.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.mainColor,
                      fontSize: 46),
                )),
          ],
        ),
      ),
    );
  }

  void _startGame() {
    Get.to(() => const LevelScreen());
  }

  void _openSettings() {
    Get.to(() => const SettingsScreen());
  }
}
