import 'package:SoulSync/screens/mood_tracker.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(
    home: MoodTrackerChartScreen(),
  ));
}

class MoodTrackerChartScreen extends StatefulWidget {
  @override
  _MoodTrackerChartScreenState createState() => _MoodTrackerChartScreenState();
}

class _MoodTrackerChartScreenState extends State<MoodTrackerChartScreen> {
  List<int> dailyMoodValues = [10, 20, 30, 5, 15, 40, 10];
  var userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    // _loadDailyMoodValues(); // Load the saved mood values from shared preferences when the screen starts
  }

  Future<void> _loadDailyMoodValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int>? moodValues = prefs
        .getStringList('daily_mood_values')
        ?.map((e) => int.parse(e))
        .toList();
    if (moodValues != null) {
      setState(() {
        dailyMoodValues = moodValues;
      });
    } else {
      dailyMoodValues = []; // Set to an empty list if moodValues is null
    }
  }

  Future<void> _saveDailyMoodValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('daily_mood_values',
        dailyMoodValues.map((value) => value.toString()).toList());
  }

  final ScrollController _scrollController = ScrollController();

  Future<List<MoodData>> fetchMoodDataFromFirestore() async {
    // Fetch mood data from Firestore and return it as a list of MoodData.
    final QuerySnapshot query = await FirebaseFirestore.instance.collection('moodData').doc(userId).collection("mood").get();
    return query.docs
        .map((doc) => MoodData.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 15, 70),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 40),
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: const Text(
                      'Mood\nTracker',
                      style: TextStyle(
                        fontSize: 39,
                        fontWeight: FontWeight.w900,
                        height: 1.2125,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                    child: FutureBuilder<List<MoodData>>(
                      future: fetchMoodDataFromFirestore(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Show a loading indicator while fetching data.
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final moodDataList = snapshot.data;
                          return LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,

                                // drawVerticalGrid: false,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: const Color(0xff37434d),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                  // bottomTitles: AxisTitles(
                                  // axisNameWidget: const Text("dates") ,
                                  // axisNameSize:16 ,
                                  // sideTitles: SideTitles(
                                  // showTitles: true,
                                  // // getTextStyles: (value) {
                                  // //   return const TextStyle(
                                  // //     color: Color(0xff68737d),
                                  // //     fontWeight: FontWeight.bold,
                                  // //     fontSize: 16,
                                  // //   );
                                  // // },
                                  // ),
                                  // // showTitles: true,
                                  // // reservedSize: 22,
                                  // // getTextStyles: (value) {
                                  // //   return const TextStyle(
                                  // //     color: Color(0xff68737d),
                                  // //     fontWeight: FontWeight.bold,
                                  // //     fontSize: 16,
                                  // //   );
                                  // // },
                                  // // axisTitles: (value) {
                                  // //   // Customize the labels for the x-axis (dates).
                                  // //   // You can format this as needed.
                                  // //   return moodDataList[value.toInt()].date.day.toString();
                                  // // },
                                  // ),
                                  leftTitles: AxisTitles(
                                      axisNameSize: 16,
                                      axisNameWidget: const Text("Moods"),
                                      sideTitles: SideTitles(
                                        getTitlesWidget: (value, meta) {
                                          return Text(value.toString());
                                        },
                                      ))),
                              borderData: FlBorderData(
                                show: true,
                                border: const Border(
                                  bottom: BorderSide(
                                      color: Color(0xff37434d), width: 1),
                                  left: BorderSide(color: Colors.transparent),
                                  right: BorderSide(color: Colors.transparent),
                                  top: BorderSide(color: Colors.transparent),
                                ),
                              ),
                              minX: 0,
                              maxX: moodDataList!.length -
                                  1.toDouble(), // Adjust this to match your data.
                              minY: 1,
                              maxY: 5,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: moodDataList
                                      .asMap()
                                      .entries
                                      .map((entry) => FlSpot(
                                          entry.key.toDouble(),
                                          entry.value.mood.toDouble()))
                                      .toList(),
                                  isCurved: true,
                                  color: Colors.white,
                                  dotData: FlDotData(show: false),
                                  belowBarData: BarAreaData(show: false),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Text('No data available');
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(21.5, 0, 28, 18),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      // Attach the scroll controller to the SingleChildScrollView
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          dayLabel('Mon'),
                          dayLabel('Tue'),
                          dayLabel('Wed'),
                          dayLabel('Thu'),
                          dayLabel('Fri'),
                          dayLabel('Sat'),
                          dayLabel('Sun'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.fromLTRB(18, 32.5, 18, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                gradient: const LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                  colors: [
                    Color(0xFF3C606A),
                    Color(0xDD56757D),
                    Color(0x9B889EA4),
                    Color(0x56BDC9CC),
                    Color(0x56BDC9CC),
                    Color(0x00FFFFFF),
                  ],
                  stops: [0, 0.401, 0.729, 0.865, 0.955, 1],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 32.5),
                    constraints: const BoxConstraints(maxWidth: 296),
                    child: const Text(
                      'See how you improve mentally every day! Keep thinking positively and reach your goals!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        height: 1.2125,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dayLabel(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 28),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w100,
          height: 1.2125,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildMoodChart() {
    List<FlSpot> spots = dailyMoodValues.asMap().entries.map((entry) {
      int dayIndex = entry.key;
      int moodValue = entry.value;
      return FlSpot(dayIndex.toDouble(), moodValue.toDouble());
    }).toList();

    return SizedBox(
      width: 400,
      height: 186,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: dailyMoodValues.length.toDouble() - 1,
          minY: 0,
          maxY: 5,
          // Assuming mood values are from 1 to 5, adjust this as needed.
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.white,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              aboveBarData: BarAreaData(show: false),
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }
}
