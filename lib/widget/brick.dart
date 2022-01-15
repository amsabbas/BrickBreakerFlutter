import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickWidth;
  final double brickHeight;
  final int brickBrokenHits;

  const Brick(
      {Key? key,
      required this.brickX,
      required this.brickY,
      required this.brickWidth,
      required this.brickHeight,
      required this.brickBrokenHits})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return brickBrokenHits == 0
        ? Container()
        : Container(
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                color: brickBrokenHits == 1 ? AppColors.blueLight100 : AppColors.blueLight,
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
              ),
            ),
          );
  }
}
