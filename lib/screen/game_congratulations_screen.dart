import 'package:brick_breaker_game/base/language/language.dart';
import 'package:brick_breaker_game/base/style/color_extension.dart';
import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameCongratulationsScreen extends StatelessWidget {
  const GameCongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            MessageKeys.congratulationTitleKey.tr,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.mainColor, fontSize: 46),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: Text(
                  MessageKeys.nextButtonTitleKey.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.mainColor,
                      fontSize: 30),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text(
                  MessageKeys.backButtonTitleKey.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.mainColor,
                      fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
