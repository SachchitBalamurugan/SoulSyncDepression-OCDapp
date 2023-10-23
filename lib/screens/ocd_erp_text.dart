import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(OCDtext());
}

class OCDtext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF044051),
          title: Text('OCD ERP Course'),
        ),
        body: CourseTopicCard(),
        // Adding a back button to the AppBar
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
          backgroundColor: Color(0xFF044051),
        ),
      ),
    );
  }
}

class CourseTopicCard extends StatefulWidget {
  @override
  _CourseTopicCardState createState() => _CourseTopicCardState();
}

class _CourseTopicCardState extends State<CourseTopicCard> {
  final FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  speakText(String text) async {
    if (isPlaying) {
      await flutterTts.pause();
    } else {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(text);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

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
              _textMethod('Topic: Understanding ERP Therapy', 20.0),
              SizedBox(height: 16.0),
              _textMethod('Description:', 16.0),
              SizedBox(height: 8.0),
              Text(
                'Exposure and Response Prevention (ERP) therapy helps individuals with conditions like Obsessive-Compulsive Disorder (OCD) tolerate uncertainty effectively. By exposing individuals to anxiety-triggering situations while preventing compulsive behaviors, ERP helps them confront and manage uncertainty. This process challenges distorted thinking patterns, teaches adaptive coping strategies, and gradually desensitizes them to discomfort. With real-life practice and lasting benefits, ERP enables individuals to navigate uncertainties with increased confidence and reduced anxiety.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  speakText(getFullText()); // Trigger text-to-speech with the full description
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

  String getFullText() {
    return "Exposure and Response Prevention (ERP) therapy helps individuals with conditions like Obsessive-Compulsive Disorder (OCD) tolerate uncertainty effectively. By exposing individuals to anxiety-triggering situations while preventing compulsive behaviors, ERP helps them confront and manage uncertainty. This process challenges distorted thinking patterns, teaches adaptive coping strategies, and gradually desensitizes them to discomfort. With real-life practice and lasting benefits, ERP enables individuals to navigate uncertainties with increased confidence and reduced anxiety.";
  }
}
