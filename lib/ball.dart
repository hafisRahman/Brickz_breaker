import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool isGameOver;
  final bool hasGameStarted;

  const MyBall({
    super.key,
    required this.ballX,
    required this.ballY, required this.isGameOver, required this.hasGameStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
            color: Colors.purple.shade900, shape: BoxShape.circle),
      ),
    );
  }
}
