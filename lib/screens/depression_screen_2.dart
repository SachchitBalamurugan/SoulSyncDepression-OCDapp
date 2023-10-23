import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(CourseScreen4());
}

class CourseScreen4 extends StatefulWidget {
  @override
  _CourseScreen4State createState() => _CourseScreen4State();
}

class _CourseScreen4State extends State<CourseScreen4> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  void toggleSpeech() async {
    if (isPlaying) {
      await flutterTts.stop();
    } else {
      await speakText();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

   speakText() async {
    try {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(
        'Depression is a mood disorder that affects millions of people worldwide. It is essential to differentiate between everyday sadness and clinical depression, as the latter can significantly impact an individual\'s life. In this topic, we will explore the characteristics of depression and its distinguishing features from ordinary sadness. Understanding the definition of depression is crucial for seeking appropriate support and treatment.',
      );
    } catch (e) {
      print('Error in text-to-speech: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    speakText();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF044051),
          title: Text('Understanding Depression Course'),
        ),
        body: CourseTopicCard(toggleSpeech: toggleSpeech, isPlaying: isPlaying),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}

class CourseTopicCard extends StatelessWidget {
  final Function toggleSpeech;
  final bool isPlaying;

  CourseTopicCard({required this.toggleSpeech, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textMethod('Topic: Definition of Depression', 20.0),
              SizedBox(height: 16.0),
              _textMethod('Description:', 16.0),
              SizedBox(height: 8.0),
              Text(
                'Depression is a mood disorder that affects millions of people worldwide. It is essential to differentiate between everyday sadness and clinical depression, as the latter can significantly impact an individual\'s life. In this topic, we will explore the characteristics of depression and its distinguishing features from ordinary sadness. Understanding the definition of depression is crucial for seeking appropriate support and treatment.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  toggleSpeech(); // Toggle speech on button press
                },
                child: Text(isPlaying ? 'Pause Speech' : 'Play Speech'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _textMethod(String textValue, double fontValue) {
    return Text(
      textValue,
      style: TextStyle(
        fontSize: fontValue,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
