import 'dart:io';  // Add this import for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'home_screen.dart';
import 'location_manager.dart';


class EventCreator extends StatefulWidget {
  @override
  State<EventCreator> createState() => _EventCreatorState();
}

class _EventCreatorState extends State<EventCreator> {
  final double fem = 1.0;
  final double ffem = 1.0;
  String titleText = ''; // Variable to store the title text
  String eventInfoText = ''; // Variable to store the event info text
  DateTime? selectedDate; // Variable to store the selected date
  File? _image; // Variable to store the selected image file

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      print("Selected image: ${pickedFile.path}");
    } else {
      print("No image selected");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Existing gradient container
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 1),
                colors: <Color>[
                  Color(0xff033f50),
                  Color(0xc9155465),
                  Color(0xd0135163),
                  Color(0x6c35778a),
                  Color(0x6d357789),
                  Color(0x45204853),
                  Color(0x45428699),
                  Color(0x005aa0b4),
                ],
                stops: <double>[0.5 , 0.543, 0.586, 1.029, 0.571, 0.514, 3.857, 3],
              ),
            ),
          ),
          // Positioned image with opacity and rounded edges
          Positioned(
            left: 0,
            top: 0,
            child: Align(
              child: SizedBox(
                width: 410,
                height: 415,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.grey, // Set the default background color here
                  ),
                  child: _image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.45), // Set the opacity here
                        BlendMode.dstATop,
                      ),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                      : null,
                ),
              ),
            ),
          ),

          // New Positioned Text
          // New Positioned Text
          Positioned(
            left: 17,
            top: 45,
            child: Align(
              child: SizedBox(
                width: 364,
                height: 95,
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      titleText = text;
                    });
                  },
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 39,
                    fontWeight: FontWeight.w900,
                    height: 1.2125,
                    color: Color(0xffffffff),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type your title here...',
                    hintStyle: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40 * fem,
            top: 290.5 * fem,
            child: Align(
              child: SizedBox(
                width: 383 * fem,
                height: 140 * fem,
                child: Text(
                  selectedDate != null
                      ? "${selectedDate!.toLocal()}".split(' ')[0] // Display the selected date
                      : 'Select date by clicking the icon...', // Display the hint text if no date is selected
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 17 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // greenfieldssector101forbibadka (148:254)
            left: 40 * fem,
            top: 320.5 * fem,
            child: Align(
              child: SizedBox(
                width: 183 * fem,
                height: 140 * fem,
                child: Text(
                  'Choose location...',
                  style: TextStyle(
                    fontFamily: 'Inter', // You can specify the font family here
                    fontSize: 17 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // attendingSTb (148:266)
            left: 41 * fem,
            top: 375 * fem,
            child: Align(
              child: SizedBox(
                width: 350 * fem,
                height: 140 * fem,
                child: Text(
                  'Attending (Auto Updates)',
                  style: TextStyle(
                    fontFamily: 'Inter', // You can specify the font family here
                    fontSize: 17 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 75.5 * fem), // Adjust the top margin accordingly
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 1098 * fem,
                height: 50 * fem,
                child: Text(
                  'Event info:',
                  style: TextStyle(
                    fontFamily: 'Inter', // You can specify the font family here
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 30, // Adjust left position as needed
            top: 473 * fem, // Adjust top position as needed
            child: Align(
              child: SizedBox(
                width: 364,
                height: 200,
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      eventInfoText = text;
                    });
                  },
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    color: Color(0xffffffff),
                  ),
                  maxLines: null, // Allow the text field to expand vertically as needed
                  expands: true, // Allow the text field to take as much vertical space as needed
                  decoration: InputDecoration(
                    hintText: 'Type your text here...',
                    hintStyle: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 505.5 * fem), // Adjust the top margin accordingly
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 1098 * fem,
                height: 70 * fem,
                child: Text(
                  'Sponsers/Special Guests:',
                  style: TextStyle(
                    fontFamily: 'Inter', // You can specify the font family here
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 30, // Adjust left position as needed
            top: 675 * fem, // Adjust top position as needed
            child: Align(
              child: SizedBox(
                width: 364,
                height: 200,
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      eventInfoText = text;
                    });
                  },
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    color: Color(0xffffffff),
                  ),
                  maxLines: null, // Allow the text field to expand vertically as needed
                  expands: true, // Allow the text field to take as much vertical space as needed
                  decoration: InputDecoration(
                    hintText: 'Type your text here...',
                    hintStyle: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 29 * fem,
            top: 766 * fem, // Adjust the top position based on your layout
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23 * fem),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 2 * fem,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to another screen or add your button click logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationSelectionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23 * fem),
                  ),
                  elevation: 0, // Set elevation to 0 as the shadow is provided by the Container
                  primary: Color(0xff7c98a1),
                ),
                child: Container(
                  width: 362 * fem, // Adjust the width based on your layout
                  height: 61 * fem, // Adjust the height based on your layout
                  child: Center(
                    child: Text(
                      'Create an Event',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w900,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 1 * fem, // Adjust left position as needed
            top: 275 * fem, // Adjust top position as needed
            child: IconButton(
              icon: Icon(
                Icons.event,
                color: Colors.white,
                size: 24 * fem,
              ),
              onPressed: () {
                _selectDate(context); // Open the date picker when the calendar icon is tapped
              },
            ),
          ),
          // New Positioned for Location Icon
          Positioned(
            left: 12 * fem, // Adjust left position as needed
            top: 320 * fem, // Adjust top position as needed
            child: Icon(
              Icons.location_on,
              color: Colors.white,
              size: 24 * fem,
            ),
          ),

// New Positioned for Attending Icon
          Positioned(
            left: 12 * fem, // Adjust left position as needed
            top: 375 * fem, // Adjust top position as needed
            child: Icon(
              Icons.people,
              color: Colors.white,
              size: 24 * fem,
            ),
          ),
          Positioned(
            left: 5,
            top: 14,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context); // Navigate back when the back button is pressed
              },
            ),
          ),
          Positioned(
            left: 148 * fem,
            top: 150 * fem,
            child: IconButton(
              icon: Icon(
                Icons.upload,
                size: 102 * fem,
              ),
              color: Colors.white,
              onPressed: () {
                _pickImage(); // Open the image picker when the upload icon is tapped
              },
            ),
          ),
        ],
      ),
    );
  }
}


void main() {
  runApp(EventCreator());
}
