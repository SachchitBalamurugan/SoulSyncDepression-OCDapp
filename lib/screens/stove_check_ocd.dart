import 'package:flutter/material.dart';
import '../widgets/bottomNavBar.dart';
void main() {
  runApp(GameApp());
}
class GameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}
class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}
class _GameScreenState extends State<GameScreen> {
  int stoveCheckCount = 0;
  bool isStoveOn = true;
  void _toggleStove() {
    setState(() {
      isStoveOn = !isStoveOn;
      stoveCheckCount++;
    });
  }
  void _resetStove() {
    setState(() {
      isStoveOn = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stove Check Compulsion"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );
          },
        ),
      ),
      body: isStoveOn
        ? GestureDetector(
          onTap: _toggleStove,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/kitchen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'Tap to Turn Off the Stove',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color(0xFF9F7F47)
                ),
              ),
            ),
          ),
        )
        : GestureDetector(
          onTap: _resetStove,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/clean_roombg.jpg'),
                fit: BoxFit.cover,
          ),
            ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You Are in a different room',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color(0xFF9F7F47)
                  )
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameScreen()),
                      );
                },
                  child: Text("Go Back To kitchen"),
                )
              ],
            ),
          ),
        )
      )
    );
  }

}