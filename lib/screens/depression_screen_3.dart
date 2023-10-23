import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(CourseScreen3());
}

class CourseScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF044051),
          title: Text('Understanding Depression Course'),
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

  speakText() async {
    if (isPlaying) {
      await flutterTts.pause();
    } else {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(
        "Hello there, It's essential to understand the global burdens of depression to gain insight into the challenges many individuals face worldwide. Depression is a complex and prevalent mental health condition that affects people of all ages, backgrounds, and cultures. As a therapist, I believe it's crucial to approach this topic with empathy and sensitivity, recognizing that each person's experience with depression is unique. Depression is more than just feeling sad or down; it can be a debilitating and overwhelming emotional state that interferes with daily functioning. It affects millions of people across the globe, impacting their relationships, work, and overall well-being. Depression doesn't discriminate; it can affect anyone, regardless of their socioeconomic status or external circumstances. The global burdens of depression are vast, and they extend beyond the individual level. Families, communities, and societies are all affected when someone struggles with depression. The economic impact is significant, as it leads to reduced productivity, increased healthcare costs, and loss of income for those unable to work. Unfortunately, depression often carries a stigma that prevents people from seeking help. Fear of judgment, shame, and misconceptions about mental health can hinder individuals from reaching out to mental health professionals like myself. As a therapist, my goal is to break down these barriers, provide a safe and supportive space, and encourage open conversations about mental health. Addressing the global burdens of depression requires a multi-faceted approach. It involves raising awareness, promoting mental health education, and enhancing access to mental health services. Encouraging empathy, understanding, and compassion can help create a more supportive environment for individuals struggling with depression. If you or someone you know is experiencing depression, remember that seeking help is a sign of strength, not weakness. As a therapist, I'm here to listen without judgment, offer guidance, and work together towards healing and growth. Remember, you are not alone in this journey, and there is hope for a brighter future.",
      );
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Topic: Understanding the global burdens of depression',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Hello there, It's essential to understand the global burdens of depression to gain insight into the challenges many individuals face worldwide. Depression is a complex and prevalent mental health condition that affects people of all ages, backgrounds, and cultures. As a therapist, I believe it's crucial to approach this topic with empathy and sensitivity, recognizing that each person's experience with depression is unique. Depression is more than just feeling sad or down; it can be a debilitating and overwhelming emotional state that interferes with daily functioning. It affects millions of people across the globe, impacting their relationships, work, and overall well-being. Depression doesn't discriminate; it can affect anyone, regardless of their socioeconomic status or external circumstances. The global burdens of depression are vast, and they extend beyond the individual level. Families, communities, and societies are all affected when someone struggles with depression. The economic impact is significant, as it leads to reduced productivity, increased healthcare costs, and loss of income for those unable to work. Unfortunately, depression often carries a stigma that prevents people from seeking help. Fear of judgment, shame, and misconceptions about mental health can hinder individuals from reaching out to mental health professionals like myself. As a therapist, my goal is to break down these barriers, provide a safe and supportive space, and encourage open conversations about mental health. Addressing the global burdens of depression requires a multi-faceted approach. It involves raising awareness, promoting mental health education, and enhancing access to mental health services. Encouraging empathy, understanding, and compassion can help create a more supportive environment for individuals struggling with depression. If you or someone you know is experiencing depression, remember that seeking help is a sign of strength, not weakness. As a therapist, I'm here to listen without judgment, offer guidance, and work together towards healing and growth. Remember, you are not alone in this journey, and there is hope for a brighter future.",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    speakText(); // Trigger text-to-speech
                  },
                  child: Text(isPlaying ? 'Pause Speech' : 'Play Speech'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
