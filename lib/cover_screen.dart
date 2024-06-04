import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;

  // font
  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 1, fontSize: 28));

  const CoverScreen(
      {super.key, required this.hasGameStarted, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment: const Alignment(0, -0.5),
            child: Text(
              isGameOver ? '' : "BRICKZ BREAKER",
              style: gameFont.copyWith(color: Colors.deepPurple.shade100),
            ),
          )
        : Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.5),
                child: Text('Brickz Breaker', style: gameFont),
              ),
              Container(
                alignment: const Alignment(0, -0.2),
                child: Text(
                  'Tap to play',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade600,
                  ),
                ),
              ),
            ],
          );
  }
}
