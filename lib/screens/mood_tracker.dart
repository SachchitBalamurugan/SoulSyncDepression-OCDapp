import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/bottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/mood_chart.dart';

void main() {
  runApp(MaterialApp(
    home: MoodTrackerScreen(),
  ));
}

class MoodTrackerScreen extends StatefulWidget {
  @override
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
   int _selectedMoodIndex = -1;

  var userId = FirebaseAuth.instance.currentUser!.uid;

  final List<String> moodLabels = [
    'Depressed',
    'Sad',
    'Neutral',
    'Happy',
    'Very Happy',
  ];

  final List<IconData> moodIcons = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
  ];

  bool isNewWeek() {
  final now = DateTime.now();
  final endOfWeek = DateTime(now.year, now.month, now.day + (7 - now.weekday));
  return now.isAfter(endOfWeek);
}


  Widget _buildMoodCard(int index) {
    return GestureDetector(
      onTap: ()async{
        setState(() {
          _selectedMoodIndex = index+1;
        });
        print(_selectedMoodIndex);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: _selectedMoodIndex == index+1
              ? const Color(0xFF8EB1BB)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(23.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              offset: Offset(0.0, 4.0),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              moodIcons[index],
              size: 30.0,
              color: Colors.white,
            ),
            const SizedBox(height: 4.0),
            Text(
              moodLabels[index],
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<MoodData>> getMoodDataForCurrentWeek() async {
  final currentWeekDates = getCurrentWeekDates();
  final startOfWeek = currentWeekDates[0];
  final endOfWeek = currentWeekDates[1];

  final query = await FirebaseFirestore.instance
      .collection('moodData').doc(userId).collection("mood")
      .where('date', isGreaterThanOrEqualTo: startOfWeek)
      .where('date', isLessThanOrEqualTo: endOfWeek)
      .get();


  final moodDataList = query.docs
      .map((doc) => MoodData.fromJson(doc.data()))
      .toList();

  return moodDataList;
}

  Future<void> saveMoodData(MoodData moodData) async {
    await FirebaseFirestore.instance.collection('moodData').doc(userId).collection("mood").add(moodData.toJson());
  }


   List<DateTime> getCurrentWeekDates() {
  final now = DateTime.now();
  final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);
  final endOfWeek = DateTime(now.year, now.month, now.day + (7 - now.weekday));
  return [startOfWeek, endOfWeek];
}

void saveMood(int mood) {
    final now = DateTime.now();
    // final currentWeekDates = getCurrentWeekDates();

    // Check if the selected date is in the future.
    List<DateTime> date = getCurrentWeekDates();
    bool isFuture = now.isBefore(date[1]);

    final moodData = MoodData(
      mood: mood,
      date: now,
      isFuture: isFuture,
    );

    // Save the mood data to Firestore.
    saveMoodData(moodData);
  }



  @override
  void initState() {
    super.initState();
  }

  void _navigateToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const BottomNavBar()), // Replace `BottomNavBar` with the desired screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(18, 40, 18, 38),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF033F50),
              Color(0xC9155465),
              Color(0xD0135163),
              Color(0x6C35778A),
              Color(0x6D357789),
              Color(0x45204853),
              Color(0x45428699),
              Color(0x005AA0B4),
            ],
            stops: [0, 0.208, 0.208, 0.589, 0.76, 0.818, 0.849, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 39, 27),
                constraints: const BoxConstraints(maxWidth: 315),
                child: const Text(
                  'How are you feeling mentally right now?',
                  style: TextStyle(
                    fontSize: 39,
                    fontWeight: FontWeight.w900,
                    height: 1.2125,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 47, 57.5),
                child: const Text(
                  '(Click on the emoji you are currently feeling right now)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.2125,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    moodLabels.length,
                    (index) => _buildMoodCard(index),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  // Replace 'selectedMood' with the user's selected mood.
                //int selectedMood = 2; // Example mood value for 'Sad'
                saveMood(_selectedMoodIndex);

                // Navigate to the chart screen.
               // Navigator.push(context, MaterialPageRoute(builder: (context) => const MoodChartScreen()));
               _navigateToNextScreen();
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(107, 0, 102, 0),
                  width: double.infinity,
                  height: 49,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8EB1BB),
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        offset: Offset(0, 4),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.255,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodData {
  int mood; // 1 for 'Depressed', 2 for 'Sad', 3 for 'Neutral', 4 for 'Happy', 5 for 'Very Happy'
  DateTime date;
  bool isFuture;

  MoodData({
    required this.mood,
    required this.date,
    required this.isFuture,
  });

  // Convert a map (Firestore document data) to a MoodData object.
  factory MoodData.fromJson(Map<String, dynamic> json) {
    return MoodData(
      mood: json['mood'] as int,
      date: (json['date'] as Timestamp).toDate(),
      isFuture: json['isFuture'] as bool,
    );
  }

  // Convert a MoodData object to a map (Firestore document data).
  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'date': date,
      'isFuture': isFuture,
    };
  }
}
