import 'package:flutter/material.dart';

class SlidingContainer extends StatefulWidget {
  const SlidingContainer({super.key});

  @override
  State<SlidingContainer> createState() => _SlidingContainerState();
}

class _SlidingContainerState extends State<SlidingContainer> {
  double playerX = 0;
  double playerWidth = 0.4; // Width as a fraction of the screen width

  // Move player left
  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  // Move player right
  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                playerX += details.delta.dx / MediaQuery.of(context).size.width;
                playerX = playerX.clamp(-1.0, 1.0);
              });
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(
                      (2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 10,
                      width:
                          MediaQuery.of(context).size.width * playerWidth / 2,
                      color: Colors.purple.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ElevatedButton(
        //       onPressed: moveLeft,
        //       child: const Icon(Icons.arrow_left),
        //     ),
        //     const SizedBox(width: 20),
        //     ElevatedButton(
        //       onPressed: moveRight,
        //       child: const Icon(Icons.arrow_right),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 20), // Adding some spacing at the bottom
      ],
    );
  }
}
