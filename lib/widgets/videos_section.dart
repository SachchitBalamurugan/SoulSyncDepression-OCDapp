// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/EventCreator.dart';
import '../screens/EventManager.dart';
import '../screens/brain_teaser.dart';
import '../screens/car_game.dart';
import '../screens/clean_ocd_help.dart';
import '../screens/cluster.dart';
import '../screens/depression_screen.dart';
import '../screens/depression_screen_2.dart';
import '../screens/depression_screen_3.dart';
import '../screens/depression_screen_sense.dart';
import '../screens/event_create_screen.dart';
import '../screens/iphone-14-12.dart';
import '../screens/iphone-14-5.dart';
import '../screens/med10.dart';
import '../screens/med11.dart';
import '../screens/med2.dart';
import '../screens/med3.dart';
import '../screens/med4.dart';
import '../screens/med5.dart';
import '../screens/med6.dart';
import '../screens/med7.dart';
import '../screens/med8.dart';
import '../screens/med9.dart';
import '../screens/meditation_screen.dart';
import '../screens/depression_screen4.dart';
import '../screens/depression_screen_6.dart';
import '../screens/depression_screen_7.dart';
import '../screens/meditation_video_ui_screen.dart';
import '../screens/memory_game.dart';
import '../screens/ocd_erp_text.dart';
import '../screens/ocd_game_theraphy.dart';
import '../screens/ocdtext2.dart';
import '../screens/pattern_recoginzation_ocd.dart';
import '../screens/sudoko.dart';
import '../screens/tapping_ocd_help.dart';
import '../screens/video_screen2.dart';
import '../screens/mood_chart.dart';
import '../screens/sleep_tracker.dart';
import '../screens/depression_screen8.dart';
import '../screens/concetration_game.dart';
import '../screens/stove_check_ocd.dart';
import '../screens/ocd_screening.dart';

class VideoSection extends StatefulWidget {
  final String? courseName;

  VideoSection({this.courseName});

  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  Map<String, List<String>> videoLists = {
    'Concentration': [
      'Introduction to concentration and its importance in academic success',
      'Memory Game',
      'Focus Game',
      'Brain Game',
      'Color Game',
      'Event Manager test',
      'Event Info Test'
    ],
    'Depression': [
      'Are you Depressed: Quiz',
      'Find the difference between positive thoughts vs Negative thoughts',
      'Definition of Depression: Differentiating sadness from clinical depression',
      'Prevalence and Impact: Understanding the global burden of depression',
      'Myths and Stigma: Addressing misconceptions about depression and reducing stigma',
      "Quiz: Myths and Stigma",
      'Self-Reflection: Encouraging individuals to explore their unique triggers and stressors',
      "Grounding Techniques: Using sensory-based exercises to stay present and centered",
      // "Distraction Techniques: Exploring healthy distractions during difficult moments",
      // "The Importance of Support: Recognizing the value of social connections during depression",
      // "Communication: Learning effective ways to express feelings and seek help",
      // "Setting Boundaries: Establishing healthy boundaries in relationships for self-care",
      // "Identifying Negative Thought Patterns: Recognizing cognitive distortions and negative self-talk",
      // "Cognitive Restructuring: Challenging and replacing negative thoughts with more balanced ones",
      // "Re:framing: Shifting perspectives to find positive aspects and solutions",
      // "Emotional Awareness: Developing skills to identify and express emotions",
      // "Emotion Regulation: Learning techniques to manage overwhelming emotions",
      // "Understanding Treatment Options: Exploring therapy, counseling, and medication as potential avenues for support",
      // "Overcoming Barriers to Seeking Help: Addressing common concerns about seeking professional assistance",
      // "Mindfulness Practices: Learning to be present and non-judgmental through mindfulness exercises",
      // "Self-Compassion: Nurturing self-kindness and acceptance in times of distress",
      // "Exercise and Depression: Understanding the connection between physical activity and mood",
      // "Nutrition and Mental Health: Exploring the impact of diet on mental well-being",
      // "Sleep Hygiene: Developing healthy sleep habits for better mental and emotional health",
      // "Resilience Skills: Building resilience to bounce back from setbacks and challenges",
      // "Long-Term Coping: Sustaining coping strategies for ongoing mental health management",
      // // Add more videos for Depression
    ],
    'Meditation': [
      'Beginner Meditation Part 1',
      'Beginner Meditation part 2',
      'Beginner Meditation Part 3',
      'Intermediate Meditation Part 1',
      'Intermediate Meditation Part 2',
      'Intermediate Meditation Part 3',
      'Advanced Meditation Part 1',
      'Advanced Meditation Part 2',
      'Advanced Meditation Part 3',
      'Advanced Meditation Part 4',
      'trial',
      // Add more videos for Meditation
    ],
    'OCD': [
      "Get Started",
      "OCD Screening",
      "Exposure",
      "Process of ERP",
      'Touching Trash ERP',
      'Tapping ERP',
      'Cleaning ERP',
      'Keeping Useless Items ERP',
      'Pressure ERP',
      'Washing Hands and Germ ERP',

  // Add more videos for OCD
    ],
  };
  CollectionReference coursesEntry =
      FirebaseFirestore.instance.collection('courses');
  var userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> videoList = videoLists[widget.courseName!] ?? [];

    return ListView.builder(
      itemCount: videoList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () async {
            log(videoList[index]);
            switch (videoList[index]) {
              case 'Introduction to concentration and its importance in academic success':
                await dataAdded(
                  'Introduction to concentration and its importance in academic success',
                  'Concentration',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConcentrationImprovementGame(),
                  ),
                );

                break;
              case 'Video 1 for Meditation':
                await dataAdded(
                  'Video 1 for Meditation',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationScreen(),
                  ),
                );
                break;
              case 'trial':
                await dataAdded(
                  'trial',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => event(),
                  ),
                );
                break;
              case 'Beginner Meditation Part 1':
                await dataAdded(
                  'Beginner Meditation Part 1',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen2(),
                  ),
                );
                break;
              case 'Beginner Meditation Part 2':
                await dataAdded(
                  'Beginner Meditation Part 2',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen3(),
                  ),
                );
                break;
              case 'Beginner Meditation Part 3':
                await dataAdded(
                  'Beginner Meditation Part 3',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen4(),
                  ),
                );
                break;
              case 'Intermediate Meditation Part 1':
                await dataAdded(
                  'Intermediate Meditation Part 1',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen5(),
                  ),
                );
                break;
              case 'Intermediate Meditation Part 2':
                await dataAdded(
                  'Intermediate Meditation Part 2',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen6(),
                  ),
                );
                break;
              case 'Intermediate Meditation Part 3':
                await dataAdded(
                  'Intermediate Meditation Part 3',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen7(),
                  ),
                );
                break;
              case 'Advanced Meditation Part 1':
                await dataAdded(
                  'Advanced Meditation Part 1',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen8(),
                  ),
                );
                break;
              case 'Advanced Meditation Part 2':
                await dataAdded(
                  'Advanced Meditation Part 2',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen9(),
                  ),
                );
                break;
              case 'Advanced Meditation Part 3':
                await dataAdded(
                  'Advanced Meditation Part 3',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen10(),
                  ),
                );
                break;
              case 'Advanced Meditation Part 4':
                await dataAdded(
                  'Advanced Meditation Part 4',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen11(),
                  ),
                );
                break;
              case 'Find the difference between positive thoughts vs Negative thoughts':
                await dataAdded(
                  'Find the difference between positive thoughts vs Negative thoughts',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                  ),
                );
                break;
              case 'Definition of Depression: Differentiating sadness from clinical depression':
                await dataAdded(
                  'Definition of Depression: Differentiating sadness from clinical depression',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseScreen4(),
                  ),
                );
                break;
              case 'Prevalence and Impact: Understanding the global burden of depression':
                await dataAdded(
                  'Prevalence and Impact: Understanding the global burden of depression',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseScreen3(),
                  ),
                );
                break;
              case 'Are you Depressed: Quiz':
                await dataAdded(
                  'Are you Depressed: Quiz',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurveyQuiz(),
                  ),
                );
                break;
              case 'Pre-Meditation':
                await dataAdded(
                  'Pre-Meditation',
                  'Meditation',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeditationVideoScreen(),
                  ),
                );
                break;
              case 'Tapping ERP':
                await dataAdded(
                  'Tapping ERP',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TappingCompulsionApp(),
                  ),
                );
                break;
              case 'Pressure ERP':
                await dataAdded(
                  'Pressure ERP',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameApp(),
                  ),
                );
                break;
              case 'Cleaning ERP':
                await dataAdded(
                  'Cleaning ERP',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CleaningCompulsionApp(),
                  ),
                );
                break;
              case 'OCD Screening':
                await dataAdded(
                  'OCD Screening',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OCDTestApp(),
                  ),
                );
                break;
              case 'Get Started':
                await dataAdded(
                  'Get Started',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scene3(),
                  ),
                );
                break;
              case 'Myths and Stigma: Addressing misconceptions about depression and reducing stigma':
                await dataAdded(
                  'Myths and Stigma: Addressing misconceptions about depression and reducing stigma',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseScreen7(),
                  ),
                );
                break;
              case 'Self-Reflection: Encouraging individuals to explore their unique triggers and stressors':
                await dataAdded(
                  'Self-Reflection: Encouraging individuals to explore their unique triggers and stressors',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UniqueTriggersScreen(),
                  ),
                );
                break;
              case "Patterns and Recurrence: Understanding how depression may manifest and recur in one's life":
                await dataAdded(
                  "Patterns and Recurrence: Understanding how depression may manifest and recur in one's life",
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoScreenDepression(),
                  ),
                );
                break;
              case "Touching Trash ERP":
                await dataAdded(
                  'Touching Trash ERP',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContaminationERPGameApp(),
                  ),
                );
                break;
              case "Washing Hands and Germ ERP":
                await dataAdded(
                  'Washing Hands and Germ ERP',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GermTapGame(),
                  ),
                );
                break;
              case "Exposure":
                await dataAdded(
                  'Exposure',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OCDtext(),
                  ),
                );
                break;
              case "Process of ERP":
                await dataAdded(
                  'Process of ERP',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OCDtext2(),
                  ),
                );
                break;
              case "Keeping Useless Items ERP":
                await dataAdded(
                  'Keeping Useless Items ERP',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HoardingCompulsionApp(),
                  ),
                );
                break;
              case "Video 2 for OCD":
                await dataAdded(
                  'Video 2 for OCD',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MoodTrackerChartScreen(),
                  ),
                );
                break;
              case "Video 3 for OCD":
                await dataAdded(
                  'Video 3 for OCD',
                  'OCD',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SleepTrackerPage(),
                  ),
                );
                break;
              case "Quiz: Myths and Stigma":
                await dataAdded(
                  'Quiz: Myths and Stigma',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DepressionMythsQuiz(),
                  ),
                );
                break;
              case "Grounding Techniques: Using sensory-based exercises to stay present and centered":
                await dataAdded(
                  'Grounding Techniques: Using sensory-based exercises to stay present and centered',
                  'Depression',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroundingTechniquesScreen(),
                  ),
                );
                break;
              case "Memory Game":
                await dataAdded(
                  'Memory Game',
                  'Concentration',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoryGameApp(),
                  ),
                );
                break;
              case "Focus Game":
                await dataAdded(
                  'Focus Game',
                  'Concentration',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FruitNinjaApp(),
                  ),
                );
                break;
              case "Brain Game":
                await dataAdded(
                  'Brain Game',
                  'Concentration',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrainTeaserApp(),
                  ),
                );
                break;
              case "Color Game":
                await dataAdded(
                  'Color Game',
                  'Concentration',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FocusGameApp(),
                  ),
                );
                break;
              case "Event Manager test":
                await dataAdded(
                  'Event Manager test',
                  'Concentration',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventManager(),
                  ),
                );
                break;
              case "Event Info Test":
                await dataAdded(
                  'Event Info Test',
                  'Concentration',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventCreator(),
                  ),
                );
                break;
              // Add cases for other video titles and corresponding screens
              default:
                // Handle the case when no matching screen is found (optional)
                break;
            }
          },
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: index == 0
                  ? const Color(0xFF674AEF)
                  : const Color(0xFF674AEF).withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: Text(videoList[index]),
          subtitle: const Text("10 min"),
        );
      },
    );
  }

  dataAdded(String textCalled, String fieldName) async {
    coursesEntry.doc(userId).collection(fieldName).doc(userId).set({
        'Course Name': textCalled,
        'Points': true,
      }); 
  }
}
