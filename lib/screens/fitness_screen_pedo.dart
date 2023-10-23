import 'package:flutter/material.dart';
import 'dart:async';

class FitnessScreen extends StatefulWidget {
  @override
  _FitnessScreenState createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  // Variables to keep track of the time and step count
  int stepCount = 0;
  Duration timeElapsed = Duration(seconds: 0);
  bool isRunning = false;

  // Timer to update the time elapsed
  Timer? timer;

  // Function to start the timer
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        timeElapsed = timeElapsed + Duration(seconds: 1);
      });
    });
  }

  // Function to stop the timer
  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  // Function to reset the step count and timer
  void resetTracking() {
    setState(() {
      stepCount = 0;
      timeElapsed = Duration(seconds: 0);
    });
    stopTimer();
  }

  // Function to handle the Start/Stop button tap
  void toggleTracking() {
    setState(() {
      if (isRunning) {
        // Stop tracking
        stopTimer();
      } else {
        // Start tracking
        startTimer();
      }
      isRunning = !isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Step Count: $stepCount',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Time Elapsed: ${timeElapsed.inMinutes}:${(timeElapsed.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: toggleTracking,
              child: Text(isRunning ? 'Stop' : 'Start'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetTracking,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
