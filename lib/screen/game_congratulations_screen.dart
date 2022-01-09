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
            'Wow',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: AppColors.blueLight, fontSize: 46),
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
                  "Next?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: AppColors.blueLight, fontSize: 30),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text(
                  "Back",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: AppColors.blueLight, fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
