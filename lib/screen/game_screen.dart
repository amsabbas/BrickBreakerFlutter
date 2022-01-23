import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/controller/game_controller.dart';
import 'package:brick_breaker_game/widget/award.dart';
import 'package:collection/collection.dart';
import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:get/get.dart';
import '../widget/ball.dart';
import '../widget/brick.dart';

import '../widget/player.dart';
import 'package:flutter/material.dart';

import 'game_congratulations_screen.dart';
import 'game_over_screen.dart';

class GameScreen extends StatefulWidget {
  final int level;

  const GameScreen({
    Key? key,
    required this.level,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late MainController _mainController;
  late Worker _gameOverWorker, _congratulationsWorker;

  @override
  void initState() {
    super.initState();
    _mainController = Get.put(getIt<MainController>());

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _mainController.initLevel(widget.level));

    _gameOverWorker = ever(_mainController.playerDead, (bool playerDead) {
      if (playerDead) {
        showGameOverScreen();
      }
    });

    _congratulationsWorker =
        ever(_mainController.allBricksBroken, (bool broken) {
      if (broken) {
        showCongratulationsScreen();
      }
    });
  }

  void showCongratulationsScreen() async {
    if (Get.currentRoute == "/GameScreen") {
      // dispose worker take some time
      final data = await Get.dialog(const GameCongratulationsScreen(),
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.04));
      if (data != null && data) {
        _mainController.resetGame();
      }
    }
  }

  void showGameOverScreen() async {
    if (Get.currentRoute == "/GameScreen") {
      // dispose worker take some time
      final data = await Get.dialog(const GameOverScreen(),
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.04));
      if (data != null && data) {
        _mainController.resetGame();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            int sensitivity = 4;

            if (details.delta.dx > sensitivity) {
              _mainController.movePlayerRight(
                  details.delta.dx / (MediaQuery.of(context).size.width/2.5));
            } else if (details.delta.dx < -sensitivity) {
              _mainController.movePlayerLeft(
                  details.delta.dx / (MediaQuery.of(context).size.width/2.5));
            }
          },
          child: GetX<MainController>(
              init: _mainController, //here
              builder: (controller) {
                return Column(
                  children: [
                    AppBar(
                      elevation: 1,
                      title: Obx(() => Text("LEVEL " +
                          _mainController.currentLevel.value.toString())),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Award(
                            awardX: _mainController.awardX.value,
                            awardY: _mainController.awardY.value,
                            awardShown: _mainController.awardShown.value,
                          ),
                          Stack(
                              children: _mainController.balls
                                  .mapIndexed((i, e) => Ball(
                                        ballX: _mainController.balls[i][0],
                                        ballY: _mainController.balls[i][1],
                                        ballShown: _mainController.balls[i][2],
                                      ))
                                  .toList()),
                          AnimatedBuilder(
                              animation: _mainController.playerX.value,
                              builder: (context, child) {
                                return Player(
                                  playerShown:
                                      _mainController.playerShown.value,
                                  playerWidth: _mainController.playerWidth,
                                  playerX: _mainController.playerX.value.value,
                                );
                              }),
                          Stack(
                              children: _mainController.bricks
                                  .mapIndexed((i, e) => Brick(
                                        brickX: _mainController.bricks[i][0],
                                        brickY: _mainController.bricks[i][1],
                                        brickWidth: _mainController.brickWidth,
                                        brickHeight:
                                            _mainController.brickHeight,
                                        brickBrokenHits:
                                            _mainController.bricks[i][2],
                                      ))
                                  .toList()),
                        ],
                      ),
                    ),
                  ],
                );
              }),
          onTap: _startGame,
        ),
      ),
    );
  }

  void _startGame() {
    _mainController.startGame();
  }

  @override
  void dispose() {
    _gameOverWorker.dispose();
    _congratulationsWorker.dispose();
    super.dispose();
  }
}
