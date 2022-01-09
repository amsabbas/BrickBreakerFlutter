import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool ballShown;

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
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                  color: AppColors.blueLight, shape: BoxShape.circle),
            ),
          )
        : Container();
  }
}
