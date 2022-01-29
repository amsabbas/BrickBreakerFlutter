import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/base/language/language.dart';
import 'package:brick_breaker_game/controller/audio_controller.dart';
import 'package:brick_breaker_game/controller/game_controller.dart';
import 'package:brick_breaker_game/widget/award.dart';
import 'package:collection/collection.dart';
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
  late final GameController _gameController;
  late final AudioController _audioController;
  late Worker _gameOverWorker,
      _congratulationsWorker,
      _awardWorker,
      _brickWorker;

  @override
  void initState() {
    super.initState();
    _gameController = Get.put(getIt<GameController>());
    _audioController = Get.put(getIt<AudioController>());

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _gameController.initLevel(widget.level));

    _gameOverWorker = ever(_gameController.playerDead, (bool playerDead) {
      if (playerDead) {
        _audioController.playGameOverAudio();
        showGameOverScreen();
      }
    });

    _awardWorker = ever(_gameController.awardShown, (bool shown) {
      if (shown) {
        _audioController.playAwardAudio();
      }
    });

    _brickWorker = ever(_gameController.brickBroken, (bool broken) {
      if (broken) {
        _audioController.playBrickAudio();
      }
    });

    _congratulationsWorker =
        ever(_gameController.allBricksBroken, (bool broken) {
      if (broken) {
        _audioController.playMissionSuccessAudio();
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
        _gameController.resetGame();
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
        _gameController.resetGame();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _gameController.resetGame();
        _audioController.stopAllGameAudio();
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).cardColor,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragUpdate: (details) {
              int sensitivity = 4;

              if (details.delta.dx > sensitivity) {
                _gameController.movePlayerRight(details.delta.dx /
                    (MediaQuery.of(context).size.width / 2.5));
              } else if (details.delta.dx < -sensitivity) {
                _gameController.movePlayerLeft(details.delta.dx /
                    (MediaQuery.of(context).size.width / 2.5));
              }
            },
            child: GetX<GameController>(
                init: _gameController, //here
                builder: (controller) {
                  return Column(
                    children: [
                      AppBar(
                        elevation: 1,
                        title: Obx(() => Text(MessageKeys.levelTitleKey.tr +
                            _gameController.currentLevel.value.toString())),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Award(
                              awardX: _gameController.awardX.value,
                              awardY: _gameController.awardY.value,
                              awardShown: _gameController.awardShown.value,
                            ),
                            Stack(
                                children: _gameController.balls
                                    .mapIndexed((i, e) => Ball(
                                          ballX: _gameController.balls[i][0],
                                          ballY: _gameController.balls[i][1],
                                          ballShown: _gameController.balls[i]
                                              [2],
                                        ))
                                    .toList()),
                            AnimatedBuilder(
                                animation: _gameController.playerX.value,
                                builder: (context, child) {
                                  return Player(
                                    playerShown:
                                        _gameController.playerShown.value,
                                    playerWidth: _gameController.playerWidth,
                                    playerX:
                                        _gameController.playerX.value.value,
                                  );
                                }),
                            Stack(
                                children: _gameController.bricks
                                    .mapIndexed((i, e) => Brick(
                                          brickX: _gameController.bricks[i][0],
                                          brickY: _gameController.bricks[i][1],
                                          brickWidth:
                                              _gameController.brickWidth,
                                          brickHeight:
                                              _gameController.brickHeight,
                                          brickBrokenHits:
                                              _gameController.bricks[i][2],
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
      ),
    );
  }

  void _startGame() {
    _gameController.startGame();
  }

  @override
  void dispose() {
    _brickWorker.dispose();
    _awardWorker.dispose();
    _gameOverWorker.dispose();
    _congratulationsWorker.dispose();
    super.dispose();
  }
}
