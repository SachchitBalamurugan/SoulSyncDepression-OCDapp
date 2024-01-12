import 'package:flutter/material.dart';

import 'home_screen.dart';

class EventManagerInfo extends StatelessWidget {
  final double fem = 1.0;
  final double ffem = 1.0;

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
                stops: <double>[
                  0.5,
                  0.543,
                  0.586,
                  1.029,
                  0.571,
                  0.514,
                  3.857,
                  3
                ],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), // Set opacity here
                      BlendMode.srcOver,
                    ),
                    child: Image.network(
                      "https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // New Positioned Text
          Positioned(
            left: 17,
            top: 45,
            child: Align(
              child: SizedBox(
                width: 364,
                height: 95,
                child: Text(
                  'Fundraiser in Ohio Dr',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 39,
                    fontWeight: FontWeight.w900,
                    height: 1.2125,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40 * fem,
            top: 291.5 * fem,
            child: Align(
              child: SizedBox(
                width: 150 * fem, // Increase the width to accommodate the text
                height: 140 * fem,
                child: Text(
                  'Jan 12, 2024',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 17,
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
                  'Greenfields, Sector 101, Forbibad',
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
                width: 150 * fem,
                height: 140 * fem,
                child: Text(
                  '10 Attending',
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
            margin: EdgeInsets.only(
                left: 30, top: 75.5 * fem), // Adjust the top margin accordingly
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
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 30,
                top: 505.5 * fem), // Adjust the top margin accordingly
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
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                    color: Color(0xffffffff),
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
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23 * fem),
                  ),
                  elevation:
                      0, // Set elevation to 0 as the shadow is provided by the Container
                  backgroundColor: Color(0xff7c98a1),
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
            left: 12 * fem, // Adjust left position as needed
            top: 290 * fem, // Adjust top position as needed
            child: Icon(
              Icons.event,
              color: Colors.white,
              size: 24 * fem,
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
                Navigator.pop(
                    context); // Navigate back when the back button is pressed
              },
            ),
          ),
        ],
      ),
    );
  }
}
