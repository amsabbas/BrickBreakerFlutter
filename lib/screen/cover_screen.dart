import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:brick_breaker_game/base/widget/empty_app_bar.dart';
import 'package:brick_breaker_game/screen/game_screen.dart';
import 'package:brick_breaker_game/widget/ball.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'level_screen.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmptyAppBar(),
        body: GestureDetector(
          onTap: startGame,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BRICK BREAKER',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: AppColors.blueLight, fontSize: 60),
                ),
                const SizedBox(height: 50,),

                Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                        color: AppColors.blueLight, shape: BoxShape.circle)),
                const SizedBox(height: 30,),
                Text(
                  'Tap to play',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: AppColors.blueLight, fontSize: 46),
                )
              ],
            ),
          ),
        ));
  }

  void startGame() {
    Get.to(() => LevelScreen());
  }
}
