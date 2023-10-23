import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import '../widgets/bottomNavBar.dart';

void main() {
  runApp(FruitNinjaApp());
}

class FruitNinjaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FruitNinjaScreen(),
    );
  }
}

class FruitNinjaScreen extends StatefulWidget {
  @override
  _FruitNinjaScreenState createState() => _FruitNinjaScreenState();
}

class _FruitNinjaScreenState extends State<FruitNinjaScreen> {
  List<Fruit> _fruits = [];
  int _score = 0;
  int _timeRemaining = 30;
  Timer? _gameTimer;

  @override
  void initState() {
    super.initState();
    startGame();
    startTimer();
  }

  void startGame() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if(mounted){
        setState(() {
        _fruits.add(Fruit());
      });
      }
      
    });
  }

  void _sliceFruit(Fruit fruit) {
    setState(() {
      if (fruit.isApple) {
        _score += 1;
      } else {
        _score -= 1;
      }
      _fruits.remove(fruit);
    });
  }

  void startTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining--;
        if (_timeRemaining <= 0) {
          _gameTimer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F6C8),
        title: const Text('Only Catch the Apple'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/clean_roombg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onPanUpdate: (details) {
            for (var fruit in _fruits.toList()) {
              if (!fruit.isSliced && fruit.isSlicedAtPosition(details.localPosition)) {
                _sliceFruit(fruit);
              }
            }
          },
          child: Stack(
            children: [
              for (var fruit in _fruits)
                if (fruit.isFalling)
                  Positioned(
                    top: fruit.position.dy,
                    left: fruit.position.dx,
                    child: fruit.image,
                  ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Score: $_score',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Time: $_timeRemaining seconds',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
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

class Fruit {
  late Offset position;
  late double fallSpeed;
  late bool isSliced;
  late bool isApple;
  late int points;
  late Widget image;
  bool isFalling = true;

  Fruit() {
    position = Offset(Random().nextInt(300).toDouble(), 0);
    fallSpeed = Random().nextInt(5).toDouble() + 1;
    isSliced = false;
    points = 1;
    isApple = Random().nextInt(2) == 0;

    final fruitAsset = isApple ? 'images/apple.png' : 'images/brick.png'; // Adjust for other fruit types
    image = Image.asset(
      fruitAsset,
      width: 100,
      height: 100,
    );

    fall();
  }

  void fall() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (position.dy < 600 && !isSliced) {
        position = Offset(position.dx, position.dy + fallSpeed);
      } else {
        isFalling = false;
        timer.cancel();
      }
    });
  }

  bool isSlicedAtPosition(Offset slicePosition) {
    if (slicePosition.dy > position.dy && slicePosition.dy < position.dy + 100) {
      double sliceDistance = (slicePosition.dx - position.dx).abs();
      if (sliceDistance < 50) {
        isSliced = true; // Mark the fruit as sliced
        return true;
      }
    }
    return false;
  }
}

