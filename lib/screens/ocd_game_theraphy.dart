import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import '../widgets/bottomNavBar.dart';

void main() {
  runApp(MaterialApp(
      home: ContaminationERPGameApp())
  );
}

class ContaminationERPGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contamination ERP Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ContaminationGameScreen(),
    );
  }
}

class ContaminationGameScreen extends StatefulWidget {
  @override
  _ContaminationGameScreenState createState() => _ContaminationGameScreenState();
}

class _ContaminationGameScreenState extends State<ContaminationGameScreen> {
  bool isTriggerVisible = false;
  bool isCompulsing = false;
  int score = 0;
  int initialTimeLimitInSeconds = 10;
  int timeLimitInSeconds = 0; // Initialize it here
  late Timer countdownTimer;
  List<String> triggerImages = [
    'images/toilet.png',
    'images/trash.png',
    'images/trashitems.png',
    // Add more image paths here
  ];

        @override
  void initState() {
    super.initState();
    timeLimitInSeconds = initialTimeLimitInSeconds;
  }


  void _showTrigger() {
    setState(() {
      isTriggerVisible = true;
      isCompulsing = false;
      timeLimitInSeconds = initialTimeLimitInSeconds;

      countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (timeLimitInSeconds == 0) {
          countdownTimer.cancel();
          _hideTrigger();
        } else {
          setState(() {
            timeLimitInSeconds--;
          });
        }
      });
    });
  }

  void _hideTrigger() {
    setState(() {
      isTriggerVisible = false;
      isCompulsing = false;
      score++;
      countdownTimer?.cancel();
    });
  }

  void _handleCompulsion() {
    setState(() {
      isCompulsing = true;
      score--;
    });
  }

  String _getRandomImage() {
    return triggerImages[Random().nextInt(triggerImages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9F7F47),
        title: Text(
          'Contamination ERP Game',
          style: TextStyle(
            color: Colors.white, // Set the text color to black
          ),
        ),
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white), // Set color to black
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
          );
        },
      ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/_81e76a1f-8fea-4046-96d2-25bdf1bdada5.jpg', // Replace with your background image path
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isTriggerVisible)
                  Image.asset(_getRandomImage()),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isCompulsing ? _hideTrigger : _showTrigger,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF9F7F47), // Set the button's background color
                  ),
                  child: Text(
                    isCompulsing ? 'Wash Hands' : 'Expose to Trigger',
                    style: TextStyle(color: Colors.white), // Set the text color
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  color: Color(0xFF9F7F47), // Set the background color to white
                  padding: EdgeInsets.all(10), // Add some padding for spacing
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score: $score',
                        style: TextStyle(
                          backgroundColor: Color(0xFF9F7F47),
                          color: Colors.white, // Set the text color to black
                          fontWeight: FontWeight.bold, // Set the text to bold
                          fontSize: 20, // Set the font size to 20 (you can adjust this value)
                        ),
                      ),
                      SizedBox(height: 10), // Add spacing between the texts
                      Text(
                        'Time Remaining: $timeLimitInSeconds seconds',
                        style: TextStyle(
                          backgroundColor: Color(0xFF9F7F47),
                          color: Colors.white, // Set the text color to black
                          fontWeight: FontWeight.bold, // Set the text to bold
                          fontSize: 20, // Set the font size to 20 (you can adjust this value)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCompulsion,
        tooltip: 'Compulsion',
        child: Icon(Icons.close, color: Colors.white,),
        backgroundColor: Color(0xFF9F7F47),
      ),
    );
  }



  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
}
