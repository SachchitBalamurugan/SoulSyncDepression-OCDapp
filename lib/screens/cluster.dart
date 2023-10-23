import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/bottomNavBar.dart';

void main() {
  runApp(HoardingCompulsionApp());
}

class HoardingCompulsionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hoarding Compulsion App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HoardingExposureScreen(),
    );
  }
}

class HoardingExposureScreen extends StatefulWidget {
  @override
  _HoardingExposureScreenState createState() => _HoardingExposureScreenState();
}

class _HoardingExposureScreenState extends State<HoardingExposureScreen> {
  bool isCluttered = true; // Simulates cluttered environment
  int score = 0;
  int timeLimitInSeconds = 10;
  late Timer countdownTimer;
  List<String> itemsToDiscard = [
    'trash.png',
    'trashitems.png',
    'dirty_glass.png',
    // Add more image paths here
  ];
  int currentItemIndex = 0;

  void _startExposure() {
    setState(() {
      isCluttered = true;
      score = 0;
      currentItemIndex = 0;
      _startCountdown();
    });
  }

  void _startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLimitInSeconds == 0) {
        countdownTimer.cancel();
        _discardItem();
      } else {
        setState(() {
          timeLimitInSeconds--;
        });
      }
    });
  }

  void _discardItem() {
    setState(() {
      score++;
      currentItemIndex++;
      timeLimitInSeconds = 10;
      if (currentItemIndex >= itemsToDiscard.length) {
        _endExposure();
      } else {
        _startCountdown();
      }
    });
  }

  void _endExposure() {
    setState(() {
      isCluttered = false;
      timeLimitInSeconds = 10;
      countdownTimer.cancel();
      currentItemIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFBFACC),
        title: Text(
          'Hoarding ERP Game',
          style: TextStyle(
            color: Colors.black, // Set the text color to black
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/clean_roombg.jpg'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCluttered && currentItemIndex < itemsToDiscard.length)
                Image.asset('images/${itemsToDiscard[currentItemIndex]}'),
              if (!isCluttered)
                Image.asset('images/organized_items.png'),
              SizedBox(height: 20),
              if (isCluttered && currentItemIndex < itemsToDiscard.length)
                ElevatedButton(
                  onPressed: _discardItem,
                  child: Text('Discard Item'),
                ),
              if (!isCluttered)
                ElevatedButton(
                  onPressed: _startExposure,
                  child: Text('Start Exposure'),
                ),
              if (!isCluttered && score >= itemsToDiscard.length)
                ElevatedButton(
                  onPressed: _endExposure,
                  child: Text('End Exposure'),
                ),
              SizedBox(height: 20),
              Text('Score: $score / ${itemsToDiscard.length}'),
              if (isCluttered) Text('Time Remaining: $timeLimitInSeconds seconds'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
}
