import 'dart:async';
import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/base/utils/shared_preference.dart';
import 'package:brick_breaker_game/controller/game_controller.dart';
import 'package:collection/collection.dart';

import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:brick_breaker_game/base/widget/empty_app_bar.dart';
import 'package:brick_breaker_game/screen/game_congratulations_screen.dart';
import 'package:get/get.dart';

import '../widget/ball.dart';
import '../widget/brick.dart';
import 'game_over_screen.dart';
import '../widget/player.dart';
import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

class GameScreen extends StatefulWidget {
  final int level;

  const GameScreen({Key? key, required this.level}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late MainController _mainController;

  late double brickWidth;
  late double brickHeight;
  late double brickGap;
  late int numberOfBrickInRow;
  late double firstBrickY;
  late double firstBrickX;
  late double wallGap;
  List bricks = [];

  double ballX = 0.0;
  double ballY = 0.0;
  bool ballShown = true;
  double ballXIncrements = 0.01;
  double ballYIncrements = 0.01;
  var ballYDirection = Direction.down;
  var ballXDirection = Direction.left;

  double playerX = -0.2;
  bool playerShown = true;
  double playerWidth = 0.5;

  bool isGameStarted = false;

  @override
  void initState() {
    super.initState();
    _mainController = Get.put(getIt<MainController>());

    brickWidth = 0.4;
    brickHeight = 0.07;
    brickGap = 0.02;
    numberOfBrickInRow = (1.5 * widget.level).ceil();
    wallGap = 0.5 *
        (2 -
            numberOfBrickInRow * brickWidth -
            (numberOfBrickInRow - 1) * brickGap);
    firstBrickY = -0.7;
    firstBrickX = -1 + wallGap;

    for (int i = 0; i < numberOfBrickInRow; i++) {
      for (int j = 0; j < numberOfBrickInRow; j++) {
        bricks.add([firstBrickX, firstBrickY + i * (brickHeight + brickGap), false]);
        bricks.add([
          firstBrickX + j * (brickWidth + brickGap),
          firstBrickY + i * (brickHeight + brickGap),
          false
        ]);
        bricks.add([
          firstBrickX + j * (brickWidth + brickGap),
          firstBrickY + i * (brickHeight + brickGap),
          false
        ]);
      }
    }
  }

  void startGame() {
    if (!isGameStarted) {
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        isGameStarted = true;
        updateDirection();
        moveBall();
        checkPlayerDead(timer);
        checkBricksBroken(timer);
      });
    }
  }

  void checkPlayerDead(Timer timer) async {
    if (isPlayerDead()) {
      timer.cancel();
      final data = await Get.dialog(const GameOverScreen(),
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.05));
      if (data) {
        resetGame();
      }
    }
  }

  void resetGame() {
    setState(() {
      isGameStarted = false;
      playerX = -0.2;
      ballX = 0.0;
      ballY = 0.0;
      playerShown = true;
      ballShown = true;
      for (int i = 0; i < bricks.length; i++) {
        bricks[i][2] = false;
      }
    });
  }

  void checkBricksBroken(Timer timer) {
    for (int i = 0; i < bricks.length; i++) {
      if (ballX >= bricks[i][0] &&
          ballX <= bricks[i][0] + brickWidth &&
          ballY <= bricks[i][1] + brickHeight &&
          bricks[i][2] == false) {
        setState(() {
          bricks[i][2] = true;

          double leftSideDist = (bricks[i][0] - ballX).abs();
          double rightSideDist = (bricks[i][0] + brickWidth - ballX).abs();
          double topSideDist = (bricks[i][1] - ballY).abs();
          double bottomSideDist = (bricks[i][1] + brickHeight - ballY).abs();

          String min =
              findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
          switch (min) {
            case "left":
              ballYDirection = Direction.left;

              break;
            case "right":
              ballYDirection = Direction.right;

              break;
            case "up":
              ballYDirection = Direction.up;

              break;
            case "down":
              ballYDirection = Direction.down;

              break;
          }
        });
      }
    }
    checkAllBricksBroken(timer);
  }

  void checkAllBricksBroken(Timer timer) async {
    bool allBroken = true;
    for (int i = 0; i < bricks.length; i++) {
      if (bricks[i][2] == false) {
        allBroken = false;
      }
    }
    if (allBroken) {
      setState(() {
        playerShown = false;
        ballShown = false;
      });
      timer.cancel();
      _mainController.updateLevel();
      final data = await Get.dialog(const GameCongratulationsScreen(),
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.05));
      if (data) {
        resetGame();
      }
    }
  }

  String findMin(double a, double b, double c, double d) {
    List<double> list = [a, b, c, d];
    double currentMin = a;
    for (int i = 0; i < list.length; i++) {
      if (currentMin > list[i]) {
        currentMin = list[i];
      }
    }
    if ((currentMin - a).abs() < 0.01) {
      return "left";
    } else if ((currentMin - b).abs() < 0.01) {
      return "right";
    } else if ((currentMin - c).abs() < 0.01) {
      return "up";
    } else if ((currentMin - d).abs() < 0.01) {
      return "down";
    }
    return '';
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      } else if (ballY <= -1) {
        ballYDirection = Direction.down;
      }

      if (ballX >= 1) {
        ballXDirection = Direction.left;
      } else if (ballX <= -1) {
        ballXDirection = Direction.right;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == Direction.left) {
        ballX -= ballXIncrements;
      } else if (ballXDirection == Direction.right) {
        ballX += ballXIncrements;
      }

      if (ballYDirection == Direction.down) {
        ballY += ballYIncrements;
      } else if (ballYDirection == Direction.up) {
        ballY -= ballYIncrements;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.1 < -1)) {
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: AppColors.whiteColor,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragUpdate: (details) {
            int sensitivity = 4;
            if (details.delta.dx > sensitivity) {
              moveRight();
            } else if (details.delta.dx < -sensitivity) {
              moveLeft();
            }
          },
          child: Center(
              child: Stack(
            children: [
              Ball(
                ballX: ballX,
                ballY: ballY,
                ballShown: ballShown,
              ),
              Player(
                playerShown: playerShown,
                playerWidth: playerWidth,
                playerX: playerX,
              ),
              Stack(
                  children: bricks
                      .mapIndexed((i, e) => Brick(
                            brickX: bricks[i][0],
                            brickY: bricks[i][1],
                            brickWidth: brickWidth,
                            brickHeight: brickHeight,
                            brickBroken: bricks[i][2],
                          ))
                      .toList()),
            ],
          )),
          onTap: startGame,
        ),
      ),
    );
  }
}
