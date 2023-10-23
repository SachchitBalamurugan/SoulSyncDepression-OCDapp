import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const int roadWidth = 5;
  static const int roadHeight = 10;
  static const int carWidth = 2;
  static const double initialGameSpeed = 200.0;
  static const double minGameSpeed = 50.0;
  static const double speedIncrement = 10.0;
  static const int distractionsPerLevel = 2;

  int carPosition = roadWidth ~/ 2;
  List<List<String>> road = List.generate(
    roadHeight,
        (i) => List.generate(
      roadWidth,
          (j) => ' ',
    ),
  );

  Random random = Random();
  double gameSpeed = initialGameSpeed;
  int score = 0;
  int level = 1;
  int distractionsSpawned = 0;

  void moveCarLeft() {
    setState(() {
      if (carPosition > 0) {
        carPosition--;
      }
    });
  }

  void moveCarRight() {
    setState(() {
      if (carPosition < roadWidth - carWidth) {
        carPosition++;
      }
    });
  }

  void updateGame() {
    for (var i = roadHeight - 1; i > 0; i--) {
      road[i] = List.from(road[i - 1]);
    }

    for (var j = 0; j < roadWidth; j++) {
      road[0][j] = ' ';
    }

    if (distractionsSpawned < distractionsPerLevel &&
        random.nextDouble() < (distractionsPerLevel - distractionsSpawned) * 0.1) {
      road[0][random.nextInt(roadWidth)] = 'D';
      distractionsSpawned++;
    }

    if (road[roadHeight - 1][carPosition] == 'D' ||
        carPosition + carWidth > roadWidth) {
      _gameOver();
    } else {
      road[roadHeight - 1].setRange(carPosition, carPosition + carWidth, ['C']);
      score++;
    }
  }

  void _gameOver() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Over'),
        content: Text('Score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text('Restart'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      carPosition = roadWidth ~/ 2;
      road = List.generate(
        roadHeight,
            (i) => List.generate(
          roadWidth,
              (j) => ' ',
        ),
      );
      gameSpeed = initialGameSpeed;
      score = 0;
      level = 1;
      distractionsSpawned = 0;
    });
    startGame();
  }

  void startGame() {
    Timer.periodic(Duration(milliseconds: gameSpeed.toInt()), (timer) {
      updateGame();
      if (score >= level * 10) {
        level++;
        if (gameSpeed > minGameSpeed) {
          gameSpeed -= speedIncrement;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            moveCarRight();
          } else if (details.delta.dx < 0) {
            moveCarLeft();
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Level: $level',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Column(
                children: List.generate(
                  roadHeight,
                      (i) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: road[i]
                        .map(
                          (cell) => Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: cell == 'C'
                              ? Colors.blue
                              : cell == 'D'
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
