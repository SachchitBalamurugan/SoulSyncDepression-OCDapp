import 'package:SoulSync/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/bottomNavBar.dart';

void main() {
  runApp(MaterialApp(
    home: SurveyQuiz(),
  ));
}

class SurveyQuiz extends StatefulWidget {
  @override
  _SurveyQuizState createState() => _SurveyQuizState();
}

class _SurveyQuizState extends State<SurveyQuiz> {
  int questionIndex = 0;
  int totalScore = 0;

  List<Map<String, dynamic>> questions = [
    {
      'questionText': 'Do you often feel sad or down?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Have you lost interest in activities you once enjoyed?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Have you had any changes in your diet or weight?',
      'answers': [
        {'text': 'No Change', 'score': 0},
        {'text': 'Small Change', 'score': 1},
        {'text': 'Moderate Change', 'score': 2},
        {'text': 'Huge Change', 'score': 3},
      ],
    },
    {
      'questionText': 'Are you feeling tired for most of the day?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Do you feel useless?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Is it hard for you to make decisions or concentrate?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Are you often restlessness?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Have you ever thought of suicide or death?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'How often are you angry?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Is it hard to finish tasks at work or school?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Do you feel you are a let down to people',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Do you feel disconnected with others?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Do you feel like crying often',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'HAve you lost interest in appearance',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    {
      'questionText': 'Do you have trouble sleeping?',
      'answers': [
        {'text': 'Never', 'score': 0},
        {'text': 'Sometimes', 'score': 1},
        {'text': 'Often', 'score': 2},
        {'text': 'Always', 'score': 3},
      ],
    },
    // Add more questions here
  ];

  void answerQuestion(int score) {
    setState(() {
      totalScore += score;
      if (questionIndex < questions.length - 1) {
        questionIndex++;
      } else {
        // Quiz completed, show result
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Quiz Result"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Your total score is $totalScore."),
                SizedBox(height: 20),
                Text(
                  _getSeverityLevel(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _getSeverityColor(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => BottomNavBar())
                  );
                      resetQuiz();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    });
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
    });
  }

  String _getSeverityLevel() {
    if (totalScore > 35) {
      return 'Severity Level: Severe';
    } else if (totalScore > 23) {
      return 'Severity Level: Moderate';
    } else if (totalScore > 14) {
      return 'Severity Level: Mild';
    } else {
      return 'Severity Level: None';
    }
  }

  Color _getSeverityColor() {
    if (totalScore > 35) {
      return Colors.red;
    } else if (totalScore > 25) {
      return Colors.orange;
    } else if (totalScore > 15) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF044051),
        title: Text("Depression Quiz"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Text(
                  questions[questionIndex]['questionText'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
                  .map((answer) => Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () => answerQuestion(answer['score']),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF044051),
                    onPrimary: Colors.white,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    answer['text'],
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
