import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  final brickHight;
  final brickWidth;
  final bool brickBrocken;
  const MyBrick(
      {super.key,
      this.brickHight,
      this.brickWidth,
      this.brickX,
      this.brickY,
      required this.brickBrocken});

  @override
  Widget build(BuildContext context) {
    return brickBrocken
        ? Container()
        : Container(
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: Colors.purple.shade900,
                height: MediaQuery.of(context).size.height * brickHight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
              ),
            ),
          );
  }
}
