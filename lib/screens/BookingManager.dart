import 'package:flutter/material.dart';

import 'EventCreator.dart';
import 'EventManager.dart';
import 'home_screen.dart';

IconData donateIcon = Icons.monetization_on; // Replace with the appropriate donation icon
IconData partyHatIcon = Icons.party_mode; // Replace with the appropriate party hat icon
IconData groupIcon = Icons.group; // Replace with the appropriate group of people icon

class BookingManager extends StatelessWidget {
  final double fem = 1.0; // Replace with your fem value
  final double ffem = 1.0; // Replace with your ffem value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                stops: <double>[0, 0.143, 0.286, 0.429, 0.571, 0.714, 0.857, 1],
              ),
            ),
          ),
          Positioned(
            left: 17 * fem,
            top: 61.5 * fem,
            child: Align(
              child: SizedBox(
                width: 343 * fem,
                height: 88 * fem,
                child: Text(
                  'Manage Your Events!',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 39 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 22 * fem,
            top: 159.5 * fem,
            child: Align(
              child: SizedBox(
                width: 124 * fem,
                height: 37 * fem,
                child: Text(
                  'Booked Events:',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          // More Events (MAIN EVNTS)
          Positioned(
            left: 20 * fem,
            top: 202 * fem,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to another screen or add your button click logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventManagerInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23 * fem),
                ),
                elevation: 2 * fem,
                primary: Color(0xff335660),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(22.97 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 355 * fem,
                height: 107 * fem,
                decoration: BoxDecoration(
                  color: Color(0xff335660),
                  borderRadius: BorderRadius.circular(23 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 18.5 * fem, 11 * fem, 28.19 * fem),
                      width: 210.03 * fem,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0.03 * fem, 0 * fem, 0 * fem, 2 * fem),
                            child: Text(
                              'Fundraiser in Ohio Dr',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w900,
                                height: 1.2125 * ffem / fem,
                                color: Color(0xff8eb1bb),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2.69 * fem),  // Adjusted margin
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Color(0xffffffff),
                                  size: 11 * ffem,
                                ),
                                SizedBox(width: 5 * fem),
                                Text(
                                  'Jan 12, 2024',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w900,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 7 * fem),  // Adjusted margin
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xffffffff),
                                  size: 11 * ffem,
                                ),
                                SizedBox(width: 5 * fem),
                                Text(
                                  'Greenfields, Sector 101, Forbibad',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w900,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 111 * fem,
                      height: 107 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14 * fem),
                        child: Image.network(
                          'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Add more Event boxes below
          ),
          //More Events (MAIN ITEMS)
          Positioned(
            left: 20 * fem,
            top: 332 * fem,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to another screen or add your button click logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventManagerInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23 * fem),
                ),
                elevation: 2 * fem,
                primary: Color(0xff335660),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(22.97 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 355 * fem,
                height: 107 * fem,
                decoration: BoxDecoration(
                  color: Color(0xff335660),
                  borderRadius: BorderRadius.circular(23 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 18.5 * fem, 11 * fem, 28.19 * fem),
                      width: 210.03 * fem,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0.03 * fem, 0 * fem, 0 * fem, 2 * fem),
                            child: Text(
                              'Fundraiser in Ohio Dr',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w900,
                                height: 1.2125 * ffem / fem,
                                color: Color(0xff8eb1bb),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2.69 * fem),  // Adjusted margin
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Color(0xffffffff),
                                  size: 11 * ffem,
                                ),
                                SizedBox(width: 5 * fem),
                                Text(
                                  'Jan 12, 2024',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w900,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 7 * fem),  // Adjusted margin
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xffffffff),
                                  size: 11 * ffem,
                                ),
                                SizedBox(width: 5 * fem),
                                Text(
                                  'Greenfields, Sector 101, Forbibad',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w900,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 111 * fem,
                      height: 107 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14 * fem),
                        child: Image.network(
                          'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Add more Event boxes below
          ),
          //Event Text under Filter Event boxes
          Positioned(
            left: 26 * fem,
            top: 463.5 * fem,
            child: Align(
              child: SizedBox(
                width: 404 * fem,
                height: 37 * fem,
                child: Text(
                  'Your Events',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 30 * ffem,
                    fontWeight: FontWeight.w900,
                    height: 1.2125 * ffem / fem,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          // Events boxes underneath the Event test (MAIN ITEMS)
          Positioned(
            left: 20 * fem,
            top: 512 * fem,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to another screen or add your button click logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventManagerInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23 * fem),
                ),
                elevation: 2 * fem,
                primary: Color(0xff335660),
              ),
              child: Container(
              padding: EdgeInsets.fromLTRB(22.97 * fem, 0 * fem, 0 * fem, 0 * fem),
              width: 355 * fem,
              height: 107 * fem,
              decoration: BoxDecoration(
                color: Color(0xff335660),
                borderRadius: BorderRadius.circular(23 * fem),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 2 * fem,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0 * fem, 18.5 * fem, 11 * fem, 28.19 * fem),
                    width: 210.03 * fem,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.03 * fem, 0 * fem, 0 * fem, 2 * fem),
                          child: Text(
                            'Fundraiser in Ohio Dr',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w900,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xff8eb1bb),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2.69 * fem),  // Adjusted margin
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Color(0xffffffff),
                                size: 11 * ffem,
                              ),
                              SizedBox(width: 5 * fem),
                              Text(
                                'Jan 12, 2024',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11 * ffem,
                                  fontWeight: FontWeight.w900,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 7 * fem),  // Adjusted margin
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0xffffffff),
                                size: 11 * ffem,
                              ),
                              SizedBox(width: 5 * fem),
                              Text(
                                'Greenfields, Sector 101, Forbibad',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 11 * ffem,
                                  fontWeight: FontWeight.w900,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 111 * fem,
                    height: 107 * fem,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14 * fem),
                      child: Image.network(
                        'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Add more Event boxes below
          ),
          // more event Boxes (MAIN ITEMS)
          Positioned(
            left: 20 * fem,
            top: 632 * fem,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to another screen or add your button click logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventManagerInfo()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23 * fem),
                ),
                elevation: 2 * fem,
                primary: Color(0xff335660),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(22.97 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 355 * fem,
                height: 107 * fem,
                decoration: BoxDecoration(
                  color: Color(0xff335660),
                  borderRadius: BorderRadius.circular(23 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 18.5 * fem, 11 * fem, 28.19 * fem),
                      width: 210.03 * fem,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0.03 * fem, 0 * fem, 0 * fem, 2 * fem),
                            child: Text(
                              'Fundraiser in Ohio Dr',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w900,
                                height: 1.2125 * ffem / fem,
                                color: Color(0xff8eb1bb),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2.69 * fem),  // Adjusted margin
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Color(0xffffffff),
                                  size: 11 * ffem,
                                ),
                                SizedBox(width: 5 * fem),
                                Text(
                                  'Jan 12, 2024',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w900,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 7 * fem),  // Adjusted margin
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xffffffff),
                                  size: 11 * ffem,
                                ),
                                SizedBox(width: 5 * fem),
                                Text(
                                  'Greenfields, Sector 101, Forbibad',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w900,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 111 * fem,
                      height: 107 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14 * fem),
                        child: Image.network(
                          'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Add more Event boxes below
          ),
        ],
      ),
    );
  }
}


void main() {
  runApp(BookingManager());
}

