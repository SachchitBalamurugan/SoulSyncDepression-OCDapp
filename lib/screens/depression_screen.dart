import 'package:SoulSync/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    home: QuizScreen(),
  ));
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  List<Question> questions = [
    Question(
      text: "I am capable of achieving my goals.",
      isPositive: true,
    ),
    Question(
      text: "Nothing ever goes my way.",
      isPositive: false,
    ),
    Question(
      text: "I learn from my mistakes and grow stronger.",
      isPositive: true,
    ),
    Question(
      text: "I will never be successful.",
      isPositive: false,
    ),
    // Add more questions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: _buildCustomAppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF044051),
              Color(0xFF135263),
              Color(0xFF35788A),
              Color(0xFF35778A),
              Color(0xFF43879A),
              Color(0xFF5AA1B5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                questions[currentQuestionIndex].text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => checkAnswer(true),
                    child: Text("Positive"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => checkAnswer(false),
                    child: Text("Negative"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return AppBar(
      title: SizedBox.shrink(),
      centerTitle: true,
      backgroundColor: Color(0xFF04323F),
      elevation: 50,
      flexibleSpace: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Positive or Negative?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = questions[currentQuestionIndex].isPositive;
    if (userAnswer == correctAnswer) {
      // User's answer is correct
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Correct!"),
            content: Text("You chose the right answer."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  moveToNextQuestion();
                },
                child: Text("Next Question"),
              ),
            ],
          );
        },
      );
    } else {
      // User's answer is wrong
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Incorrect"),
            content: Text("You chose the wrong answer."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  moveToNextQuestion();
                },
                child: Text("Next Question"),
              ),
            ],
          );
        },
      );
    }
  }

  void moveToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // All questions answered, show a message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Quiz Complete"),
              content: Text("You have completed the quiz."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => BottomNavBar())
                    );
                    // You can do something here after completing the quiz
                  },
                  child: Text("Done"),
                ),
              ],
            );
          },
        );
      }
    });
  }
}

class Question {
  final String text;
  final bool isPositive;

  Question({required this.text, required this.isPositive});
}
