import 'package:flutter/material.dart';
import '../widgets/bottomNavBar.dart';

void main() {
  runApp(CleaningCompulsionApp());
}

class CleaningCompulsionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cleaning Compulsion App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CleaningExposureScreen(),
    );
  }
}

class CleaningExposureScreen extends StatefulWidget {
  @override
  _CleaningExposureScreenState createState() => _CleaningExposureScreenState();
}

class _CleaningExposureScreenState extends State<CleaningExposureScreen> {
  int dirtyImageIndex = 0; // Index to track current dirty image
  int cleanImageIndex = 0; // Index to track current clean image
  bool isDirty = true; // Simulates the presence of dirt

  // Array of dirty and clean images
  List<String> dirtyImages = [
    'images/dirty_plate.png',
    'images/dirty_glass.png',
    // Add more dirty image paths here
  ];
  List<String> cleanImages = [
    'images/clean_plate.png',
    'images/clean_glass.png',
    // Add more clean image paths here
  ];

  void _cleanItem() {
    setState(() {
      dirtyImageIndex++; // Move to the next dirty image
      cleanImageIndex++; // Move to the next clean image
      if (dirtyImageIndex >= dirtyImages.length) {
        dirtyImageIndex = 0; // Reset to the first dirty image
        cleanImageIndex = 0; // Reset to the first clean image
        isDirty = false; // Mark the item as cleaned
      }
    });
  }

  void _resetItem() {
    setState(() {
      dirtyImageIndex = 0; // Reset the dirty image index
      cleanImageIndex = 0; // Reset the clean image index
      isDirty = true; // Simulate the item being dirty again
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7CBCCE),
        title: Text(
          'Contamination ERP Game',
          style: TextStyle(
            color: Colors.white, // Set the text color to black
          ),
        ),
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
      body: Stack(
        children: [
          Image.asset(
            'images/kitchen.jpg', // Background image path
            fit: BoxFit.cover, // Scale the image to cover the entire screen
            width: double.infinity, // Make the image width cover the screen width
            height: double.infinity, // Make the image height cover the screen height
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  isDirty ? dirtyImages[dirtyImageIndex] : cleanImages[cleanImageIndex],
                ),
                SizedBox(height: 20),
                if (isDirty)
                  GestureDetector(
                    onTap: _cleanItem,
                    child: Image.asset(
                      'images/soapbar.png', // Sponge image path
                      width: 300, // Set the width of the sponge image
                      height: 300, // Set the height of the sponge image
                    ),
                  ),
                if (!isDirty)
                  GestureDetector(
                    onTap: _resetItem,
                    child: Image.asset(
                      'images/soapbar.png', // Sponge image path
                      width: 300, // Set the width of the sponge image
                      height: 300, // Set the height of the sponge image
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
