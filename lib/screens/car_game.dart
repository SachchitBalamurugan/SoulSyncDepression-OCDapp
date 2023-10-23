import 'package:flutter/material.dart';
import '../widgets/bottomNavBar.dart';
import 'dart:async';
import 'dart:math';

import '../widgets/videos_section.dart';

void main() {
  runApp(FocusGameApp());
}

class FocusGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimonSaysScreen(),
    );
  }
}

class SimonSaysScreen extends StatefulWidget {
  @override
  _SimonSaysScreenState createState() => _SimonSaysScreenState();
}

class _SimonSaysScreenState extends State<SimonSaysScreen> {
  List<int> sequence = [];
  List<int> playerSequence = [];
  int currentIndex = 0;
  int score = 0;
  bool isGameActive = false;
  bool isGameOver = false;

  late Timer _timer;
  int _secondsRemaining = 10;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    sequence.clear();
    playerSequence.clear();
    currentIndex = 0;
    score = 0;
    isGameActive = true;
    isGameOver = false;
    _generateSequence();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          timer.cancel();
          isGameActive = false;
          isGameOver = true;
        }
      });
    });
  }

  void _generateSequence() {
    Random random = Random();
    sequence.add(random.nextInt(4));
    playSequence();
  }

  void playSequence() async {
    for (int i = 0; i < sequence.length; i++) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        currentIndex = sequence[i];
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        currentIndex = -1;
      });
    }
  }

  void checkAnswer(int buttonIndex) {
    if (isGameActive) {
      setState(() {
        playerSequence.add(buttonIndex);
        if (playerSequence[playerSequence.length - 1] != sequence[playerSequence.length - 1]) {
          isGameActive = false;
          isGameOver = true;
          _timer.cancel();
        } else if (playerSequence.length == sequence.length) {
          score++;
          playerSequence.clear();
          _generateSequence();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simon Says Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Time: $_secondsRemaining seconds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (isGameActive)
              SimonButton(
                color: Colors.red,
                isActive: currentIndex == 0,
                onTap: () => checkAnswer(0),
              ),
            SizedBox(height: 20),
            if (isGameActive)
              SimonButton(
                color: Colors.green,
                isActive: currentIndex == 1,
                onTap: () => checkAnswer(1),
              ),
            SizedBox(height: 20),
            if (isGameActive)
              SimonButton(
                color: Colors.blue,
                isActive: currentIndex == 2,
                onTap: () => checkAnswer(2),
              ),
            SizedBox(height: 20),
            if (isGameActive)
              SimonButton(
                color: Colors.yellow,
                isActive: currentIndex == 3,
                onTap: () => checkAnswer(3),
              ),
            if (isGameOver)
              Text(
                'Game Over!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isGameOver ? startGame : null,
              child: Text('Start Game'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()),
                );
              },
              child: Text('Go to Home Screen'),
            ),

          ],
        ),
      ),
    );
  }
}

class SimonButton extends StatelessWidget {
  final Color color;
  final bool isActive;
  final VoidCallback onTap;

  SimonButton({
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        color: isActive ? color.withOpacity(0.8) : color,
      ),
    );
  }
}
