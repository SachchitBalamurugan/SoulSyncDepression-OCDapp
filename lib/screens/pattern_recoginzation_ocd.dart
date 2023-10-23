import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import '../widgets/bottomNavBar.dart';

void main() {
  runApp(GermTapGame());
}

class GermTapGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GermTapScreen(),
    );
  }
}

class GermTapScreen extends StatefulWidget {
  @override
  _GermTapScreenState createState() => _GermTapScreenState();
}

class _GermTapScreenState extends State<GermTapScreen> {
  List<Offset> germs = [];
  int score = 0;
  late Timer germTimer;

  @override
  void initState() {
    super.initState();
    germTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      addGerm();
    });
  }

  @override
  void dispose() {
    germTimer.cancel();
    super.dispose();
  }

  void addGerm() {
    setState(() {
      final random = Random();
      final germX = random.nextDouble() * (MediaQuery.of(context).size.width - 50);
      final germY = random.nextDouble() * (MediaQuery.of(context).size.height - 50);
      germs.add(Offset(germX, germY));
    });
  }

  void onTapGerm(Offset germOffset) {
    setState(() {
      germs.remove(germOffset);
      score++;
    });
  }

  // Function to show the instructions dialog
  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How to Play'),
          content: Text(
            'Tap on the germs to eliminate them and earn points.\n'
                'Be quick and accurate to achieve the highest score!',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Germ ERP Game'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              _showInstructionsDialog(context);
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTapDown: (details) {
          for (var germOffset in List.from(germs)) {
            final germRect = Rect.fromCircle(center: germOffset, radius: 25);
            if (germRect.contains(details.globalPosition)) {
              onTapGerm(germOffset);
              break;
            }
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/hand.jpg', // Replace with your background image path
                fit: BoxFit.cover,
              ),
            ),
            for (var germOffset in germs)
              Positioned(
                left: germOffset.dx,
                top: germOffset.dy,
                child: GestureDetector(
                  onTap: () => onTapGerm(germOffset),
                  child: Image.asset('images/germ.png', width: 250, height: 250),
                ),
              ),
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              'Score: $score',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Change color if needed
              ),
            ),
          ),
        ),
      ),
          ],
        ),
      ),
    );
  }
}
