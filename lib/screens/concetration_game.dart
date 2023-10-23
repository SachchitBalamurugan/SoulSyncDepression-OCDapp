import 'package:flutter/material.dart';

void main() {
  runApp(ConcentrationImprovementGame());
}

class ConcentrationImprovementGame extends StatefulWidget {
  @override
  _ConcentrationImprovementGameState createState() => _ConcentrationImprovementGameState();
}

class _ConcentrationImprovementGameState extends State<ConcentrationImprovementGame> {
  int points = 0;

  void _addPoints() {
    setState(() {
      points += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF044051),
          title: Text('Concentration Improvement Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tips to Improve Concentration:',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              _buildConcentrationTip(
                '1. Create a Distraction-Free Environment:',
                'Find a quiet place with minimal distractions to enhance focus and concentration.',
              ),
              SizedBox(height: 10.0),
              _buildConcentrationTip(
                '2. Take Regular Breaks:',
                'Break your tasks into smaller chunks and take short breaks in between to recharge your mind.',
              ),
              SizedBox(height: 10.0),
              _buildConcentrationTip(
                '3. Practice Mindfulness:',
                'Engage in mindfulness techniques such as meditation to train your mind to stay present and attentive.',
              ),
              SizedBox(height: 10.0),
              _buildConcentrationTip(
                '4. Stay Organized:',
                'Keep a to-do list and prioritize tasks to stay organized and focused on what\'s important.',
              ),
              SizedBox(height: 10.0),
              _buildConcentrationTip(
                '5. Limit Multitasking:',
                'Avoid multitasking as it can lead to decreased productivity and attention.',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: Color(0xff044051),
          child: Icon(Icons.check),
        ),
      ),
    );
  }

  Widget _buildConcentrationTip(String title, String description) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
