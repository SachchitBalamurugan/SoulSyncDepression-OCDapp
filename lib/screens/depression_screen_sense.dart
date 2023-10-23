import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(GroundingTechniquesScreen());
}

class GroundingTechniquesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF044051),
          title: Text('Grounding Techniques'),
        ),
        body: GroundingTechniquesCard(),
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

class GroundingTechniquesCard extends StatefulWidget {
  @override
  _GroundingTechniquesCardState createState() => _GroundingTechniquesCardState();
}

class _GroundingTechniquesCardState extends State<GroundingTechniquesCard> {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Grounding Techniques: Staying Present and Centered Using Sensory-Based Exercises',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Grounding practices can help people stay vigilant and concentrated in the face of life\'s hardships. These activities help us handle anxiety, depression, stress, and overpowering feelings by activating all of our senses. Let\'s look at several sensory-based grounding strategies that may be used in daily life:',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                _buildGroundingTechnique(
                  title: '5-4-3-2-1:',
                  description: 'Spend a few moments studying the world around you. Identify five items you can look at, four items you can feel, three that you can listen to, two that you can smell, and one that you can taste. This activity helps to divert your attention away from unwelcome ideas and promotes awareness.',
                ),
                SizedBox(height: 8.0),
                _buildGroundingTechnique(
                  title: 'Deep Breathing:',
                  description: 'Settle into a position of ease and take steady, deep breaths. Feel how air enters your lungs and note how it feels when you exhale. Deep breathing relaxes the mind, relieves stress, and returns the focus back to the current moment.',
                ),
                SizedBox(height: 8.0),
                _buildGroundingTechnique(
                  title: 'Texture Exploration:',
                  description: 'Take an item with a unique texture, such as a rough rock or a soft cloth. Keep an eye on how the material feels in your grasp. Interacting with your senses anchors you in the world of reality and fosters a sense of belonging.',
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
      ),
    );
  }

  Widget _buildGroundingTechnique({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  String getFullText() {
    return "Grounding practices can help people stay vigilant and concentrated in the face of life's hardships. These activities help us handle anxiety, depression, stress, and overpowering feelings by activating all of our senses. Let's look at several sensory-based grounding strategies that may be used in daily life: 5-4-3-2-1: Spend a few moments studying the world around you. Identify five items you can look at, four items you can feel, three that you can listen to, two that you can smell, and one that you can taste. This activity helps to divert your attention away from unwelcome ideas and promotes awareness. Deep Breathing: Settle into a position of ease and take steady, deep breaths. Feel how air enters your lungs and note how it feels when you exhale. Deep breathing relaxes the mind, relieves stress, and returns the focus back to the current moment. Texture Exploration: Take an item with a unique texture, such as a rough rock or a soft cloth. Keep an eye on how the material feels in your grasp. Interacting with your senses anchors you in the world of reality and fosters a sense of belonging.";
  }
}
