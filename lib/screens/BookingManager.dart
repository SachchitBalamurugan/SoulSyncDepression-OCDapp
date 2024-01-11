import 'package:flutter/material.dart';

import '../widgets/eventCard.dart';
import '../widgets/eventCategory.dart';
import 'EventCreator.dart';
import 'EventManager.dart';
import 'home_screen.dart';

IconData donateIcon =
    Icons.monetization_on; // Replace with the appropriate donation icon
IconData partyHatIcon =
    Icons.party_mode; // Replace with the appropriate party hat icon
IconData groupIcon =
    Icons.group; // Replace with the appropriate group of people icon

class BookingManager extends StatelessWidget {
  final double fem = 1.0; // Replace with your fem value
  final double ffem = 1.0; // Replace with your ffem value

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.blueGrey,
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Expanded(
    //             child: Container(
    //               child: Text('Hello'),
    //             ),
    //           ),
    //           Expanded(
    //             child: Text('Another Test'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Manage your \nEvents!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 39 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.2125 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                EventCategory(txt: 'Booked'),
                EventCard(subject: 'Fundraiser in Ohio Dr'),
                EventCard(subject: 'Fundraiser in WDC'),
                EventCategory(txt: 'Your Events'),
                EventCard(subject: 'Fundraiser in LA'),
                EventCard(subject: 'Fundraiser in Vegas'),
                EventCard(subject: 'Fundraiser in UK'),
                EventCard(subject: 'Fundraiser in LA'),
                EventCard(subject: 'Fundraiser in Vegas'),
                EventCard(subject: 'Fundraiser in UK'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
