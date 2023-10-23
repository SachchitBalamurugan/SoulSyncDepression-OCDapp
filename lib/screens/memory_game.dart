import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MemoryGameScreen(),
    );
  }
}

class MemoryGameScreen extends StatefulWidget {
  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  List<int> tileValues = [];
  List<bool> tileFlipped = [];
  int previousTileIndex = -1;
  int score = 0;
  bool isProcessing = false;

  final int numTiles = 16;
  late Timer _timer;
  int _secondsRemaining = 60;
  bool _isGameFinished = false;

  @override
  void initState() {
    super.initState();
    initializeTiles();
    startTimer();
  }
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0 && !_isGameFinished) {
          _secondsRemaining--;
        } else {
          timer.cancel();
        }
      });
    });
  }
  void checkGameFinished() {
    if (!tileFlipped.contains(false)) {
      _isGameFinished = true;
      _timer.cancel();
    }
  }


  void initializeTiles() {
    tileValues = List.generate(numTiles ~/ 2, (index) => index + 1)
        .followedBy(List.generate(numTiles ~/ 2, (index) => index + 1))
        .toList();
    tileValues.shuffle();
    tileFlipped = List.filled(numTiles, false);
  }


  void onTileTap(int index) {
    if (isProcessing || tileFlipped[index]) return;

    setState(() {
      tileFlipped[index] = true;

      if (previousTileIndex == -1) {
        previousTileIndex = index;
      } else {
        isProcessing = true;
        Future.delayed(const Duration(seconds: 1), () {
          if (tileValues[index] != tileValues[previousTileIndex]) {
            tileFlipped[index] = false;
            tileFlipped[previousTileIndex] = false;
          } else {
            score += 10; // Increment the score for a successful match
          }
          previousTileIndex = -1;
          isProcessing = false;
          setState(() {});
          checkGameFinished(); // Move this line outside of Future.delayed
        });
      }
    });
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
        title: Text('Memory Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'Time: $_secondsRemaining seconds',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: numTiles,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onTileTap(index),
                    child: Card(
                      color: tileFlipped[index] ? Colors.white : Colors.blue,
                      child: Center(
                        child: tileFlipped[index]
                            ? Text(
                          tileValues[index].toString(),
                          style: TextStyle(fontSize: 20),
                        )
                            : Icon(
                          Icons.memory,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            initializeTiles();
            score = 0;
            _secondsRemaining = 60; // Reset timer when restarting the game
            _isGameFinished = false;
            startTimer(); // Restart the timer

          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

