import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;

// font
  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 1, fontSize: 28));

  const GameOverScreen({super.key, required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.3),
                child: Text(
                  ' G A M E     O V E R',
                  style: gameFont,
                ),
              ),
              Container(
                alignment: const Alignment(0, 0.1),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.deepPurple,
                      child: Text(
                        ' PLAY AGAIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
