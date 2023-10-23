import 'package:flutter/material.dart';
import '../widgets/bottomNavBar.dart';
import '../widgets/videos_section.dart';

void main() {
  runApp(TappingCompulsionApp());
}

class TappingCompulsionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tapping Compulsion App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TappingGameScreen(),

    );
  }
}

class TappingGameScreen extends StatefulWidget {
  @override
  _TappingGameScreenState createState() => _TappingGameScreenState();
}

class _TappingGameScreenState extends State<TappingGameScreen> {
  int score = 0;

  void _incrementScore() {
    setState(() {
      score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tapping Compulsion App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap the Screen!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _incrementScore,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Score: $score',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
          );
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Color(0xFF044051),
      ),
    );
  }
}
