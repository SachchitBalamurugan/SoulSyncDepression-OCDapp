import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(CourseScreen7());
}

class CourseScreen7 extends StatelessWidget {
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
        "Addressing myths and reducing stigma surrounding depression is crucial in creating a supportive and empathetic environment for individuals facing this mental health challenge. Let's debunk some common misconceptions and explore strategies to combat stigma: Myth: Depression is just feeling sad and can be easily overcome. Reality: Depression is a complex and serious mental health condition that goes beyond normal feelings of sadness. It involves a combination of biological, psychological, and social factors. Overcoming depression often requires professional help, support from loved ones, and evidence-based treatments. Myth: People with depression are weak or lazy. Reality: Depression is not a sign of weakness or laziness. It is a medical condition that affects the brain's functioning. Just like any other health condition, individuals with depression require understanding and support. Myth: Depression is not a real illness; it's all in the person's head. Reality: Depression is a legitimate medical condition with real neurobiological and physiological changes in the brain. It is not a matter of willpower, and the symptoms are not imaginary. Myth: Only certain types of people get depressed. Reality: Depression can affect anyone regardless of age, gender, race, or social status. It does not discriminate, and anyone can experience depression at some point in their life. Myth: Seeking help for depression is a sign of weakness. Reality: Seeking help for depression is a courageous and proactive step towards healing. It takes strength to reach out for support and to work on one's mental health. Reducing stigma surrounding depression: Educate and raise awareness: Providing accurate information about depression and its causes can help dispel myths and increase understanding. Educational campaigns can target schools, workplaces, and communities. Use language carefully: Avoid using derogatory terms or stigmatizing language when talking about depression or mental health. Instead, use compassionate and person-first language that emphasizes the individual's experiences and challenges rather than labeling them. Encourage open conversations: Creating safe spaces for people to talk about their mental health experiences without judgment is essential. Honest discussions about depression can help normalize the conversation and reduce stigma. Share personal stories: Sharing personal experiences of depression can be empowering and help others feel less alone in their struggles. This can humanize the condition and challenge stigmatizing beliefs. Support mental health initiatives: Advocate for increased funding and resources for mental health services. Support organizations that promote mental health awareness and provide assistance to those in need. Be empathetic and non-judgmental: Show compassion and understanding towards individuals experiencing depression. Avoid making assumptions or trivializing their feelings. By challenging misconceptions and addressing stigma, we can create a more inclusive and supportive society where individuals feel comfortable seeking help and receiving the support they need to overcome depression. As a therapist, I am committed to fighting stigma, providing empathetic care, and advocating for the well-being of all individuals facing mental health challenges.",
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
                  'Topic: Myths and Stigma: Addressing misconceptions about depression and reducing stigma',
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
                  "Addressing myths and reducing stigma surrounding depression is crucial in creating a supportive and empathetic environment for individuals facing this mental health challenge. Let's debunk some common misconceptions and explore strategies to combat stigma: Myth: Depression is just feeling sad and can be easily overcome. Reality: Depression is a complex and serious mental health condition that goes beyond normal feelings of sadness. It involves a combination of biological, psychological, and social factors. Overcoming depression often requires professional help, support from loved ones, and evidence-based treatments. Myth: People with depression are weak or lazy. Reality: Depression is not a sign of weakness or laziness. It is a medical condition that affects the brain's functioning. Just like any other health condition, individuals with depression require understanding and support. Myth: Depression is not a real illness; it's all in the person's head. Reality: Depression is a legitimate medical condition with real neurobiological and physiological changes in the brain. It is not a matter of willpower, and the symptoms are not imaginary. Myth: Only certain types of people get depressed. Reality: Depression can affect anyone regardless of age, gender, race, or social status. It does not discriminate, and anyone can experience depression at some point in their life. Myth: Seeking help for depression is a sign of weakness. Reality: Seeking help for depression is a courageous and proactive step towards healing. It takes strength to reach out for support and to work on one's mental health. Reducing stigma surrounding depression: Educate and raise awareness: Providing accurate information about depression and its causes can help dispel myths and increase understanding. Educational campaigns can target schools, workplaces, and communities. Use language carefully: Avoid using derogatory terms or stigmatizing language when talking about depression or mental health. Instead, use compassionate and person-first language that emphasizes the individual's experiences and challenges rather than labeling them. Encourage open conversations: Creating safe spaces for people to talk about their mental health experiences without judgment is essential. Honest discussions about depression can help normalize the conversation and reduce stigma. Share personal stories: Sharing personal experiences of depression can be empowering and help others feel less alone in their struggles. This can humanize the condition and challenge stigmatizing beliefs. Support mental health initiatives: Advocate for increased funding and resources for mental health services. Support organizations that promote mental health awareness and provide assistance to those in need. Be empathetic and non-judgmental: Show compassion and understanding towards individuals experiencing depression. Avoid making assumptions or trivializing their feelings. By challenging misconceptions and addressing stigma, we can create a more inclusive and supportive society where individuals feel comfortable seeking help and receiving the support they need to overcome depression. As a therapist, I am committed to fighting stigma, providing empathetic care, and advocating for the well-being of all individuals facing mental health challenges.",
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
