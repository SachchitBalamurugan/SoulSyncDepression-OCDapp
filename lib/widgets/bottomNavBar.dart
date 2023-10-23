// ignore_for_file: file_names

import 'package:SoulSync/screens/python_chat.dart';
import 'package:flutter/material.dart';

import '../screens/community.dart';
import '../screens/home_screen.dart';
import '../screens/mood_chart.dart';
import '../screens/running_tracker_screen.dart';
import '../screens/theraphist_nearme.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    RunningTrackerPage(),
    MoodTrackerChartScreen(),
    Scene2(),
    Scene(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PythonChat(),
          ));
        },
        child: const ImageIcon(AssetImage("images/bot-icon.png")),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.area_chart),
            label: 'Mood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Theraphy',
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        iconSize: 32,
        unselectedFontSize: 13,
        selectedItemColor: const Color(0xFF038C73),
        selectedFontSize: 18,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
