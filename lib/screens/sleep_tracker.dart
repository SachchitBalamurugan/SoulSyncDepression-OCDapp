import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SleepTrackerPage extends StatefulWidget {
  @override
  _SleepTrackerPageState createState() => _SleepTrackerPageState();
}

class _SleepTrackerPageState extends State<SleepTrackerPage> {
  List<int> dailySleepValues = [];

  @override
  void initState() {
    super.initState();
    _loadDailySleepValues();
  }

  Future<void> _loadDailySleepValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int>? sleepValues = prefs.getStringList('daily_sleep_values')?.map((e) => int.parse(e)).toList();
    if (sleepValues != null && sleepValues.isNotEmpty) {
      setState(() {
        dailySleepValues = sleepValues;
      });
    }
  }

  Future<void> _saveDailySleepValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'daily_sleep_values',
      dailySleepValues.map((value) => value.toString()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 40),
                constraints: BoxConstraints(maxWidth: 200),
                child: Text(
                  'Sleep Tracker',
                  style: TextStyle(
                    fontSize: 39,
                    fontWeight: FontWeight.w900,
                    height: 1.2125,
                    color: Colors.white,
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildSleepChart(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Track your Sleep Duration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16),
              Slider(
                value: dailySleepValues.isEmpty ? 0 : dailySleepValues.last.toDouble(),
                onChanged: (value) {
                  setState(() {
                    dailySleepValues.add(value.toInt());
                  });
                },
                min: 0,
                max: 10, // Adjust this as needed based on your desired sleep duration range
                divisions: 100,
                label: dailySleepValues.isEmpty ? '0' : dailySleepValues.last.toString(),
              ),
              ElevatedButton(
                onPressed: () {
                  _saveDailySleepValues();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sleep duration saved successfully!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Text('Save Sleep Duration', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSleepChart() {
    List<FlSpot> spots = dailySleepValues.asMap().entries.map((entry) {
      int dayIndex = entry.key;
      int sleepDuration = entry.value;
      return FlSpot(dayIndex.toDouble(), sleepDuration.toDouble());
    }).toList();

    return Container(
      width: 400,
      height: 186,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: dailySleepValues.length.toDouble() - 1,
          minY: 0,
          maxY: 10, // Adjust this as needed based on your sleep duration range
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

void main() {
  runApp(MaterialApp(
    home: SleepTrackerPage(),
  ));
}
