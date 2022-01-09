import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:brick_breaker_game/base/utils/shared_preference.dart';
import 'package:brick_breaker_game/base/widget/empty_app_bar.dart';
import 'package:brick_breaker_game/controller/game_controller.dart';
import 'package:brick_breaker_game/screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late MainController _mainController;

  @override
  void initState() {
    super.initState();
    _mainController = Get.put(getIt<MainController>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: AppColors.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'GAME LEVEL',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: AppColors.blueLight, fontSize: 46),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: GetX<MainController>(
                      init: _mainController, //here
                      builder: (controller) {
                        int level = _mainController.level.value;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () => startGame(index + 1, level),
                            child: Card(
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 0,
                              child: Container(
                                color: (index + 1) <= level
                                    ? AppColors.blueLight
                                    : AppColors.offWhiteColor,
                                child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            color: (index + 1) <= level
                                                ? AppColors.whiteColor
                                                : AppColors.greyLightColor,
                                            fontSize: 60),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemCount: 500,
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }

  void startGame(int index, int level) {
    if (index <= level) {
      Get.to(
        () => GameScreen(
          level: index,
        ),
      );
    }
  }
}
