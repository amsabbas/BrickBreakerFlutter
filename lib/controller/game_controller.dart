import 'dart:async';
import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/base/utils/shared_preference.dart';

import 'package:get/get.dart';

enum Direction { up, down, left, right, none }

class MainController extends GetxController {
  RxInt level = 1.obs;
  RxInt currentLevel = 1.obs;
  late SharedPrefs _sharedPrefs;

  late double brickWidth;
  late double brickHeight;
  late double brickGap;
  late int numberOfBrickInRow;
  late int numberOfBrickInColumn;
  late double firstBrickY;
  late double firstBrickX;
  late double wallGap;
  RxBool allBricksBroken = false.obs;
  RxList bricks = [].obs;

  RxDouble ballX = 0.0.obs;
  RxDouble ballY = 0.0.obs;
  RxBool ballShown = true.obs;
  double ballXIncrements = 0.01;
  double ballYIncrements = 0.01;
  var ballYDirection = Direction.down;
  var ballXDirection = Direction.left;

  RxDouble playerX = (-0.2).obs;
  RxBool playerShown = true.obs;
  RxBool playerDead = false.obs;
  double playerWidth = 0.5;
  bool isGameStarted = false;

  @override
  void onInit() {
    super.onInit();
    _sharedPrefs = getIt<SharedPrefs>();
  }

  void loadLevel() {
    level.value = (_sharedPrefs.getInt("level") ?? 1);
  }

  void initLevel(int level) {
    currentLevel.value = level;
    _initBricks();
    resetGame();
  }

  void updateLevel() {
    currentLevel.value++;
    int savedLevel = _sharedPrefs.getInt("level") ?? 1;
    if (currentLevel.value > savedLevel) {
      _sharedPrefs.putInt("level", currentLevel.value);
      level.value = currentLevel.value;
    }
  }

  void _initBricks() {
    brickWidth = 0.4;
    brickHeight = 0.07;
    brickGap = 0.02;
    numberOfBrickInRow = currentLevel % 2 == 0
        ? ((currentLevel * 3)).ceil() % 4 + 1
        : ((currentLevel * 2)).ceil() % 5 + 1;

    numberOfBrickInColumn = currentLevel % 2 == 0
        ? ((currentLevel * 3)).ceil() % 4 + 1
        : ((currentLevel * 2)).ceil() % 4 + 1;
    wallGap = 0.5 *
        (2 -
            numberOfBrickInRow * brickWidth -
            (numberOfBrickInRow - 1) * brickGap);
    firstBrickY = -0.7;
    firstBrickX = -1 + wallGap;

    bricks.clear();
    for (int i = 0; i < numberOfBrickInRow; i++) {
      for (int j = 0; j < numberOfBrickInColumn; j++) {
        bricks.add([
          firstBrickX + i * (brickWidth + brickGap),
          firstBrickY + j * (brickHeight + brickGap),
          false
        ]);
      }
    }
    bricks.refresh();
  }

  void startGame() {
    if (!isGameStarted) {
      Timer.periodic(const Duration(milliseconds: 10), (timer) {
        isGameStarted = true;
        _updateDirection();
        _moveBall();
        _checkPlayerDead(timer);
        _checkBricksBroken(timer);
      });
    }
  }

  void _checkPlayerDead(Timer timer) async {
    if (ballY >= 1) {
      // player dead
      playerDead.value = true;
      timer.cancel();
    }
  }

  void resetGame() {
    _initBricks();
    ballYDirection = Direction.down;
    ballXDirection = Direction.left;
    isGameStarted = false;
    playerX.value = (-0.2);

    ballX.value = 0.0;

    ballY.value = 0.0;

    playerShown.value = true;

    ballShown.value = true;

    playerDead.value = false;

    allBricksBroken.value = false;

    for (int i = 0; i < bricks.length; i++) {
      bricks[i][2] = false;
    }
    bricks.refresh();
  }

  void _checkBricksBroken(Timer timer) {
    for (int i = 0; i < bricks.length; i++) {
      if (ballX >= bricks[i][0] &&
          ballX <= bricks[i][0] + brickWidth &&
          ballY <= bricks[i][1] + brickHeight &&
          ballY >= bricks[i][1] &&
          bricks[i][2] == false) {
        bricks[i][2] = true;

        double leftSideDist = (bricks[i][0] - ballX.value).abs();
        double rightSideDist = (bricks[i][0] + brickWidth - ballX.value).abs();
        double topSideDist = (bricks[i][1] - ballY.value).abs();
        double bottomSideDist =
            (bricks[i][1] + brickHeight - ballY.value).abs();

        Direction min =
            _findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
        switch (min) {
          case Direction.left:
            ballXDirection = Direction.left;
            break;
          case Direction.right:
            ballXDirection = Direction.right;
            break;
          case Direction.up:
            ballYDirection = Direction.up;
            break;
          case Direction.down:
            ballYDirection = Direction.down;
            break;
          case Direction.none:
            break;
        }
      }
    }
    _checkAllBricksBroken(timer);
  }

  void _checkAllBricksBroken(Timer timer) async {
    bool allBroken = true;
    for (int i = 0; i < bricks.length; i++) {
      if (bricks[i][2] == false) {
        allBroken = false;
      }
    }
    if (allBroken) {
      playerShown.value = false;
      ballShown.value = false;
      allBricksBroken.value = true;
      timer.cancel();
      updateLevel();
    }
  }

  Direction _findMin(double a, double b, double c, double d) {
    List<double> list = [a, b, c, d];
    double currentMin = a;
    for (int i = 0; i < list.length; i++) {
      if (currentMin > list[i]) {
        currentMin = list[i];
      }
    }
    if ((currentMin - a).abs() < 0.01) {
      return Direction.left;
    } else if ((currentMin - b).abs() < 0.01) {
      return Direction.right;
    } else if ((currentMin - c).abs() < 0.01) {
      return Direction.up;
    } else if ((currentMin - d).abs() < 0.01) {
      return Direction.down;
    }
    return Direction.none;
  }

  void _updateDirection() {
    if (ballY >= 0.9 &&
        ballX >= playerX.value &&
        ballX <= playerX.value + playerWidth) {
      ballYDirection = Direction.up;
    } else if (ballY <= -1) {
      ballYDirection = Direction.down;
    }

    if (ballX >= 1) {
      ballXDirection = Direction.left;
    } else if (ballX <= -1) {
      ballXDirection = Direction.right;
    }
  }

  void _moveBall() {
    if (ballXDirection == Direction.left) {
      ballX.value -= ballXIncrements;
    } else if (ballXDirection == Direction.right) {
      ballX.value += ballXIncrements;
    }

    if (ballYDirection == Direction.down) {
      ballY.value += ballYIncrements;
    } else if (ballYDirection == Direction.up) {
      ballY.value -= ballYIncrements;
    }

    ballX.refresh();
    ballY.refresh();
  }

  void movePlayerLeft() {
    if (!(playerX.value - 0.1 < -1)) {
      playerX.value -= 0.1;
    }
    playerX.refresh();
  }

  void movePlayerRight() {
    if (!(playerX.value + playerWidth >= 1)) {
      playerX.value += (0.1);
    }
    playerX.refresh();
  }

  @override
  void dispose() {
    super.dispose();
    currentLevel.close();
    level.close();
    bricks.close();
    ballX.close();
    ballY.close();
    ballShown.close();
    playerX.close();
    playerShown.close();
  }
}
