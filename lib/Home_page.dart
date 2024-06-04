import 'dart:async';

import 'package:brickz_breaker/ball.dart';
import 'package:brickz_breaker/brick.dart';
import 'package:brickz_breaker/cover_screen.dart';
import 'package:brickz_breaker/gameOver_screen.dart';
import 'package:brickz_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum direction { UP, DOWN, LEFT, RIGHT }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  //ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXincrements = 0.01;
  double ballYincrements = 0.01;
  var ballYDiarection = direction.DOWN;
  var ballXDiarection = direction.LEFT;

  // player variables
  double playerX = -0.2;
  double playerWidth = 0.4; // out of 2

  // brick Variables

  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4; // out of 2
  static double brickHight = 0.05; // out of 2
  static double brickGap = 0.02;
  static int numberOfBricksInRow = 4;
  // add On
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  bool brickBroken = false;
  int brokenBrickCount = 0;




  List myBricks = [
    // (x,y , broken = true/false)
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];

  // game settings

  bool hasGameStarted = false;
  bool isGameOver = false;

// start gane
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 15), (timer) {
      // update direction
      updateDirection();

      // move ball
      moveBall();

      // check if player dead

      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }
      // check if brick is hit
      checkForBrokenBricks();
    });
  }

  // check if brick is hit
  void checkForBrokenBricks() {
    // check for when ball hits bottom of brick
    for (var i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY <= myBricks[i][1] + brickHight &&
          myBricks[i][2] == false) {
        setState(() {
          myBricks[i][2] = true;


          // since brick is broken , update direction of ball
          // based on which side of the brick it hit
          // to do this , calculate the distance of the ball from  each of the 4 sides.
          // the smallest distance is the side the ball has it

          double leftSidedist = (myBricks[i][0] - ballX).abs();
          double rightSidedist = (myBricks[i][0] + brickWidth - ballX).abs();
          double topSidedist = (myBricks[i][1] - ballY).abs();
          double bottomSidedist = (myBricks[i][1] + brickHight - ballY).abs();

          String min =
              findmin(leftSidedist, rightSidedist, topSidedist, bottomSidedist);

          switch (min) {
            case 'left':
              ballXDiarection = direction.LEFT;
              break;
            case 'right':
              ballXDiarection = direction.RIGHT;
              break;
            case 'up':
              ballYDiarection = direction.UP;
              break;
            case 'down':
              ballYDiarection = direction.DOWN;
              break;

            default:
          }
  

        });
      }
    }
  }


  //return the smallest side
  String findmin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];

    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }

    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'up';
    } else if ((currentMin - d).abs() < 0.01) {
      return 'down';
    }
    return '';
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    } else {
      return false;
    }
  }

  void moveBall() {
    setState(() {
      // move horizontally
      if (ballXDiarection == direction.LEFT) {
        ballX -= ballXincrements;
      } else if (ballXDiarection == direction.RIGHT) {
        ballX += ballXincrements;
      }

      // move vertically
      if (ballYDiarection == direction.DOWN) {
        ballY += ballYincrements;
      } else if (ballYDiarection == direction.UP) {
        ballY -= ballYincrements;
      }
    });
  }

  void updateDirection() {
    setState(() {
      // ball goas up when hit the player
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDiarection = direction.UP;

        //   ball goas down when hit the top of screan
      } else if (ballY <= -0.9) {
        ballYDiarection = direction.DOWN;
      }

      // ball goas LEFT when hit right wall
      if (ballX >= 1) {
        ballXDiarection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDiarection = direction.RIGHT;
      }

      // ball goas right when hit left wall
    });
  }

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

  // reset game to its initial values when user hits play again
  void resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStarted = false;

      myBricks = [
        // (x,y , broken = true/false)
        [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          playerX += details.delta.dx / MediaQuery.of(context).size.width;
          playerX = playerX.clamp(-1.0, 1.0);
        });
      },
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade200,
        body: Center(
            child: Stack(
          children: [
            // Tap to play
            CoverScreen(
              hasGameStarted: hasGameStarted,
              isGameOver: isGameOver,
            ),

            // Game Over
            GameOverScreen(
              isGameOver: isGameOver,
              function: resetGame,
            ),

            //ball
            MyBall(
                ballX: ballX,
                ballY: ballY,
                hasGameStarted: hasGameStarted,
                isGameOver: isGameOver),

            //player
            MyPlayer(
              playerX: playerX,
              playerWidth: playerWidth,
            ),

            //Bricks
            MyBrick(
                brickX: myBricks[0][0],
                brickY: myBricks[0][1],
                brickHight: brickHight,
                brickWidth: brickWidth,
                brickBrocken: myBricks[0][2]),
            MyBrick(
              brickX: myBricks[1][0],
              brickY: myBricks[1][1],
              brickHight: brickHight,
              brickWidth: brickWidth,
              brickBrocken: myBricks[1][2],
            ),
            MyBrick(
              brickX: myBricks[2][0],
              brickY: myBricks[2][1],
              brickHight: brickHight,
              brickWidth: brickWidth,
              brickBrocken: myBricks[2][2],
            )
          ],
        )),
      ),
    );
  }

  void _handleLeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        moveLeft();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        moveRight();
      }
    }
  }
}
