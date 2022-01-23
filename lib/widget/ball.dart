import 'package:brick_breaker_game/base/style/color_extension.dart';
import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool ballShown;
  final double ballWidth = 15;
  final double ballHeight = 15;

  const Ball(
      {Key? key,
      required this.ballX,
      required this.ballY,
      required this.ballShown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ballShown
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: Container(
              width: ballWidth,
              height: ballHeight,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.mainColor,
                  shape: BoxShape.circle),
            ),
          )
        : Container();
  }
}
