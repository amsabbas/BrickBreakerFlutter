import 'dart:async';
import 'package:brick_breaker_game/base/injection/general_injection.dart';
import 'package:brick_breaker_game/base/utils/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:brick_breaker_game/model/game_configuration.dart';

import 'package:get/get.dart';

enum Direction { up, down, left, right, none }

class MainController extends GetxController {
  int _refreshDurationInMilliseconds = 8;
  bool _isGameStarted = false;

  RxInt level = 1.obs;
  RxInt currentLevel = 1.obs;
  late SharedPrefs _sharedPrefs;

  late double brickWidth;
  late double brickHeight;
  late double _brickGapWidth;
  late double _brickGapHeight;
  late int _numberOfBrickInRow;
  late int _numberOfBrickInColumn;
  late double _firstBrickY;
  late double _firstBrickX;
  late double _wallGap;
  late int _brickBrokenHits;
  RxBool allBricksBroken = false.obs;
  RxList bricks = [].obs;

  RxDouble ballX = 0.0.obs;
  RxDouble ballY = 0.0.obs;
  RxBool ballShown = true.obs;
  final double _ballXIncrements = 0.01;
  final double _ballYIncrements = 0.01;
  Direction _ballYDirection = Direction.down;
  Direction _ballXDirection = Direction.left;

  Rx<ValueNotifier<double>> playerX = ValueNotifier(-0.2).obs;
  RxBool playerShown = true.obs;
  RxBool playerDead = false.obs;
  double playerWidth = 0.5;

  RxDouble awardX = 0.0.obs;
  RxDouble awardY = 1.0.obs;
  final double _awardYIncrements = 0.01;
  RxBool awardShown = false.obs;
  int brickAwardTime = 0;

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
    if (currentLevel > 10) {
      _refreshDurationInMilliseconds = 7;
    }
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

  void _initBricks() async {
    final String level = await rootBundle
        .loadString("assets/levels/" + currentLevel.value.toString() + ".json");
    final jsonResult = jsonDecode(level);
    final brickConfiguration = BrickConfiguration(
      row: jsonResult['row'],
      column: jsonResult['column'],
      matrix: jsonResult['matrix'],
      widthGap: jsonResult['widthGap'],
      heightGap: jsonResult['heightGap'],
      brickBrokenHits: jsonResult['brickBrokenHits'],
      brickWidth: jsonResult['brickWidth'],
      brickHeight: jsonResult['brickHeight'],
    );

    brickWidth = brickConfiguration.brickWidth;
    brickHeight = brickConfiguration.brickHeight;
    _brickBrokenHits = brickConfiguration.brickBrokenHits;
    _numberOfBrickInRow = brickConfiguration.row;
    _numberOfBrickInColumn = brickConfiguration.column;
    _brickGapWidth = brickConfiguration.widthGap;
    _brickGapHeight = brickConfiguration.heightGap;

    _wallGap = 0.5 *
        (2 -
            _numberOfBrickInRow * brickWidth -
            (_numberOfBrickInRow - 1) * _brickGapWidth);
    _firstBrickY = -0.7;
    _firstBrickX = -1 + _wallGap;

    bricks.clear();
    for (int i = 0; i < _numberOfBrickInRow; i++) {
      for (int j = 0; j < _numberOfBrickInColumn; j++) {
        int matrix = brickConfiguration.matrix[i][j];
        if (matrix != 0) {
          bricks.add([
            _firstBrickX + i * (brickWidth + _brickGapWidth),
            _firstBrickY + j * (brickHeight + _brickGapHeight),
            _brickBrokenHits
          ]);
        }
      }
    }
    bricks.refresh();
  }

  void startGame() {
    if (!_isGameStarted) {
      Timer.periodic(Duration(milliseconds: _refreshDurationInMilliseconds),
          (timer) {
        _isGameStarted = true;
        _updateDirection();
        _moveBall();
        _checkForAward();
        _updateAward();
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
    _ballYDirection = Direction.down;
    _ballXDirection = Direction.left;
    _isGameStarted = false;
    playerX.value.value = (-0.2);
    ballX.value = 0.0;
    ballY.value = 0.0;
    playerShown.value = true;
    ballShown.value = true;
    playerDead.value = false;
    allBricksBroken.value = false;

    for (int i = 0; i < bricks.length; i++) {
      bricks[i][2] = 1;
    }
    bricks.refresh();
  }

  void _checkForAward() {
    if (awardY.value >= 0.9 &&
        awardX.value >= playerX.value.value &&
        awardX.value <= playerX.value.value + playerWidth &&
        awardShown.value) {
      playerWidth = 0.9;
      awardX.value = 0.0;
      awardY.value = 0.0;
      awardShown.value = false;
      Future.delayed(const Duration(seconds: 15), () {
        playerWidth = 0.5;
      });
    }
  }

  void _addAward(double x, double y) {
    if (awardShown.value == false) {
      awardX.value = x;
      awardY.value = y;
      awardShown.value = true;
    }
  }

  void _updateAward() {
    if (awardY >= 0.9) {
      awardShown.value = false;
      return;
    }
    awardY.value += _awardYIncrements;
  }

  void _checkBricksBroken(Timer timer) {
    for (int i = 0; i < bricks.length; i++) {
      if (ballX >= bricks[i][0] &&
          ballX <= bricks[i][0] + brickWidth &&
          ballY <= bricks[i][1] + brickHeight &&
          ballY >= bricks[i][1] &&
          bricks[i][2] > 0) {
        bricks[i][2]--;

        if (brickAwardTime > 0) {
          int currentTime = DateTime.now().second;
          if (currentTime - brickAwardTime <= 1) {
            _addAward(ballX.value, ballY.value);
          }
        }
        brickAwardTime = DateTime.now().second;

        double leftSideDist = (bricks[i][0] - ballX.value).abs();
        double rightSideDist = (bricks[i][0] + brickWidth - ballX.value).abs();
        double topSideDist = (bricks[i][1] - ballY.value).abs();
        double bottomSideDist =
            (bricks[i][1] + brickHeight - ballY.value).abs();

        Direction min =
            _findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
        switch (min) {
          case Direction.left:
            _ballXDirection = Direction.left;
            break;
          case Direction.right:
            _ballXDirection = Direction.right;
            break;
          case Direction.up:
            _ballYDirection = Direction.up;
            break;
          case Direction.down:
            _ballYDirection = Direction.down;
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
      if (bricks[i][2] > 0) {
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
        ballX >= playerX.value.value &&
        ballX <= playerX.value.value + playerWidth) {
      _ballYDirection = Direction.up;
    } else if (ballY <= -1) {
      _ballYDirection = Direction.down;
    }

    if (ballX >= 1) {
      _ballXDirection = Direction.left;
    } else if (ballX <= -1) {
      _ballXDirection = Direction.right;
    }
  }

  void _moveBall() {
    if (_ballXDirection == Direction.left) {
      ballX.value -= _ballXIncrements;
    } else if (_ballXDirection == Direction.right) {
      ballX.value += _ballXIncrements;
    }

    if (_ballYDirection == Direction.down) {
      ballY.value += _ballYIncrements;
    } else if (_ballYDirection == Direction.up) {
      ballY.value -= _ballYIncrements;
    }
  }

  void movePlayerLeft() {
    if (!(playerX.value.value - 0.1 < -1)) {
      playerX.value.value -= 0.1;
    }
  }

  void movePlayerRight() {
    if (!(playerX.value.value + playerWidth >= 1)) {
      playerX.value.value += (0.1);
    }
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
    playerDead.close();
    allBricksBroken.close();
  }
}
