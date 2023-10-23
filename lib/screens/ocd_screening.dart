import 'package:SoulSync/screens/home_screen.dart';
import 'package:SoulSync/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(OCDTestApp());
}

class OCDTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OCD Screening Test',
      home: OCDTestScreen(),
    );
  }
}

class OCDTestScreen extends StatefulWidget {
  @override
  _OCDTestScreenState createState() => _OCDTestScreenState();
}

class _OCDTestScreenState extends State<OCDTestScreen> {
  Map<String, bool> answers = {
    "Concerns with contamination or serious illness": false,
    "Over concern with order": false,
    "Images of death or horrible events": false,
    "Personally unacceptable religious or sexual thoughts": false,
    "Worries about terrible things happening": false,
    "Compulsive acts like washing or checking": false,
    "Acting on unwanted and senseless urge or impulse": false,
    "Repeating routine actions": false,
    "Need to touch objects or people": false,
    "Unnecessary re-reading or re-writing": false,
    "Examining your body for signs of illness": false,
    "Avoiding colors, numbers, or names": false,
    "Needing to confess or ask for reassurance": false,
  };

  int calculateScore() {
    int score = 0;
    answers.values.forEach((value) {
      if (value == true) {
        score++;
      }
    });
    return score;
  }

  String getScoreDescription(int score) {
    if (score >= 13) {
      return 'OCD is likely / high risk';
    } else if (score >= 8) {
      return 'OCD is probable / at risk';
    } else {
      return 'OCD Unlikely';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF044051),
        title: Text('OCD Screening Test'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => BottomNavBar()
                ),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          for (var question in answers.keys)
            ListTile(
              title: Text(question),
              subtitle: Column(
                children: [
                  RadioListTile<bool>(
                    title: Text('No'),
                    value: false,
                    groupValue: answers[question],
                    onChanged: (value) {
                      setState(() {
                        answers[question] = value!;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: Text('Yes'),
                    value: true,
                    groupValue: answers[question],
                    onChanged: (value) {
                      setState(() {
                        answers[question] = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ElevatedButton(
            onPressed: () {
              int score = calculateScore();
              String scoreDescription = getScoreDescription(score);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('OCD Test Result'),
                    content: Text('Your score: $score\n$scoreDescription'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BottomNavBar(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF044051), // Set the button color
                        ),
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF044051), // Set the button color
            ),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
