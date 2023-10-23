import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class OCDtext2 extends StatefulWidget {
  @override
  _OCDtext2State createState() => _OCDtext2State();
}

class _OCDtext2State extends State<OCDtext2> {
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  List<String> textToRead = [
    '1. Develop a Hierarchy: Work with a trained therapist to create a hierarchy of anxiety-provoking situations or triggers. Arrange them from least to most anxiety-inducing.',
    '2. Set Goals: Define clear goals for each exposure session. These goals should focus on resisting compulsive behaviors and tolerating the associated anxiety.',
    '3. Gradual Exposure: Begin with exposures that are less anxiety-provoking and gradually move up the hierarchy as tolerance improves.',
    '4. Prevent Compulsions: Commit to not engaging in compulsive behaviors or rituals during exposure. This is crucial for breaking the cycle of anxiety and response.',
    '5. Stay in the Situation: Remain in the anxiety-inducing situation until your anxiety naturally decreases. Avoid leaving the situation or performing rituals prematurely.',
    '6. Practice Mindful Observation: Closely observe your thoughts, feelings, and physical sensations during exposure. Practice non-judgmental awareness.',
    '7. Embrace Acceptance: Recognize that anxiety is a natural response. Focus on changing your relationship with anxiety instead of attempting to eliminate it entirely.',
    '8. Avoid "Safety" Behaviors: Refrain from using behaviors or mental rituals to alleviate anxiety during exposure. This includes avoidance, checking, or seeking reassurance.',
    '9. Record Progress: Keep a record of your exposure sessions, noting anxiety levels, thoughts, and reactions. This helps track your advancement.',
    '10. Repeat and Vary: Regularly repeat exposure sessions and introduce variations in contexts. This ensures that your learning is adaptable to diverse situations.',
    '11. Exercise Patience and Persistence: Recognize that ERP can present challenges, and progress may not always be linear. Approach the process with patience and persistent effort.',
    '12. Seek Professional Guidance: ERP is most effective when guided by a trained therapist. Their support ensures tailored exposures, assistance, and safety throughout the process.',
    '13. Prioritize Self-Care: Incorporate self-care practices outside of exposure sessions to manage overall stress and well-being.',
    '14. Apply Learning to Real-Life Scenarios: Transfer the skills acquired in ERP to real-life situations. This facilitates the integration of therapeutic gains into daily experiences.',
    '15. Celebrate Success: Acknowledge and celebrate your accomplishments, no matter how small. Overcoming challenges in ERP is a significant achievement.'
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setCompletionHandler(() {
      if (currentIndex < textToRead.length - 1) {
        currentIndex++;
        playText();
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  void playText() async {
    if (currentIndex < textToRead.length) {
      await flutterTts.speak(textToRead[currentIndex]);
    }
  }

  void pauseText() async {
    await flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF044051),
        title: Text('ERP Theraphy: What is it?'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exposure and Response Prevention (ERP) for OCD: Steps and Considerations',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: textToRead.length,
                itemBuilder: (context, index) {
                  return Text(textToRead[index], style: TextStyle(fontSize: 16.0));
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      isPlaying = true;
                    });
                    playText();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    pauseText();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
