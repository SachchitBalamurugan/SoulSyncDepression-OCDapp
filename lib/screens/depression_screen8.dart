import 'package:flutter/material.dart';

import '../widgets/bottomNavBar.dart';
import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: DepressionMythsQuiz(),
  ));
}

class DepressionMythsQuiz extends StatefulWidget {
  @override
  _DepressionMythsQuizState createState() => _DepressionMythsQuizState();
}

class _DepressionMythsQuizState extends State<DepressionMythsQuiz> {
  int questionIndex = 0;
  int totalScore = 0;
  String answerFeedback = '';

  List<Map<String, dynamic>> questions = [
    {
      'questionText': 'Depression is just a sign of weakness.',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
    {
      'questionText': 'Depression is only caused by traumatic events.',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
    {
      'questionText': 'People with depression can simply "snap out of it."',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
    {
      'questionText': 'Depression is not a real medical condition.',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
    {
      'questionText': 'Only adults can experience depression.',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
    {
      'questionText': 'Taking medication for depression is always the best solution.',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
    {
      'questionText': 'People with depression are just seeking attention.',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
    {
      'questionText': 'Depression will go away on its own with time.',
      'answers': [
        {'text': 'True', 'score': 0},
        {'text': 'False', 'score': 1},
      ],
    },
  ];

  void answerQuestion(int score) {
    setState(() {
      totalScore += score;
      answerFeedback = score > 0 ? 'Right' : 'Wrong';
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            answerFeedback = '';
          });
        });
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
                  _getFeedback(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
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
      answerFeedback = '';
    });
  }

  String _getFeedback() {
    if (totalScore <= 3) {
      return 'Great job! You have a good understanding of depression and its myths.';
    } else if (totalScore <= 6) {
      return 'Not bad! You have some knowledge, but there are still some misconceptions.';
    } else {
      return 'There are some myths you need to learn more about depression. Consider educating yourself about this topic.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF044051),
        title: Text("Depression Myths Quiz"),
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
                    fontSize: 20,
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
                  onPressed: answerFeedback.isNotEmpty ? null : () {
                    answerQuestion(answer['score']);
                  },
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
              SizedBox(height: 10),
              answerFeedback.isNotEmpty
                  ? Text(
                answerFeedback,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: answerFeedback == 'Right' ? Colors.green : Colors.red,
                ),
              )
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
