import 'package:brick_breaker_game/base/style/color_extension.dart';
import 'package:brick_breaker_game/base/style/colors.dart';
import 'package:flutter/material.dart';

class Award extends StatelessWidget {
  final double awardX;
  final double awardY;
  final bool awardShown;
  final double awardWidth = 20;
  final double awardHeight = 20;

  const Award(
      {Key? key,
      required this.awardX,
      required this.awardY,
      required this.awardShown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return awardShown
        ? Container(
            alignment: Alignment(awardX, awardY),
            child: SizedBox(
              width: awardWidth,
              height: awardHeight,
              child: Center(
                  child: Icon(
                Icons.expand,
                color: Theme.of(context).colorScheme.mainColor,
              )),
            ),
          )
        : Container();
  }
}
