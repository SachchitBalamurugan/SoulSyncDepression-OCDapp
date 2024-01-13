import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../consts/firebase_constants.dart';
import '../consts/firestore_services.dart';
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

class EventManager extends StatefulWidget {
  @override
  State<EventManager> createState() => _EventManagerState();
}

class _EventManagerState extends State<EventManager> {
  DateTime? selectedDate;
  late String month = 'January';

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        month = DateFormat.MMMM().format(selectedDate!);
      });
    }
    print(selectedDate);
  }

  final double fem = 1.0;
  // Replace with your fem value
  final double ffem = 1.0;
  // Replace with your ffem value
  @override
  Widget build(BuildContext context) {
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
                    'Upcoming Events',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 39 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.2125 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: EventCategory(txt: month),
                      ),
                      onPressed: () {
                        _selectDate(
                            context); // Open the date picker when the calendar icon is tapped
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff335660)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Adjust the radius as needed
                          ),
                        ),
                      )),
                ),
                // Scrolling Days
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 362 * fem,
                    height: 79 * fem,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        // Determine the day name based on the index (0 is Sunday, 1 is Monday, etc.)
                        String dayName = [
                          'Sun',
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat'
                        ][index];

                        // Check if it's Tuesday and change the background color and text color
                        Color bgColor = dayName == 'Tue'
                            ? Color(0xff8eb1bb)
                            : Color(0xff335660);
                        Color textColor = dayName == 'Tue'
                            ? Color(0xff335660)
                            : Color(0xff8eb1bb);

                        return Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 9 * fem, 0 * fem),
                          width: 44 * fem,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(9 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3f000000),
                                offset: Offset(0 * fem, 4 * fem),
                                blurRadius: 2 * fem,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 9.5 * fem,
                                top: 44 * fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 26 * fem,
                                    height: 20 * fem,
                                    child: Text(
                                      dayName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5 * ffem / fem,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 11 * fem,
                                top: 11 * fem,
                                child: Align(
                                  child: SizedBox(
                                    width: 23 * fem,
                                    height: 36 * fem,
                                    child: Text(
                                      (index + 1).toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 24 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5 * ffem / fem,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Create Event Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to another screen or add your button click logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventCreator()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23 * fem),
                      ),
                      elevation: 2 * fem,
                      backgroundColor: Color(0xff335660),
                    ),
                    child: Container(
                      width: 362 * fem, // Adjust the width based on your layout
                      height:
                          61 * fem, // Adjust the height based on your layout
                      child: Center(
                        child: Text(
                          'Create an Event',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w900,
                            height: 1.2125 * ffem / fem,
                            color: Color(0xff8eb1bb),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                EventCategory(txt: 'Filter Events'),
                SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: FilterEventCats(
                          fem: fem,
                          ffem: ffem,
                          name: "Fundraiser",
                          icon: donateIcon),
                    ),
                    SizedBox(width: 12),
                    FilterEventCats(
                        fem: fem, ffem: ffem, name: 'Gala', icon: partyHatIcon),
                    SizedBox(width: 12),
                    FilterEventCats(
                        fem: fem,
                        ffem: ffem,
                        name: 'Programs',
                        icon: groupIcon),
                  ],
                ),
                SizedBox(height: 8.0),
                // Events on The Day
                EventCategory(txt: 'Events'),
                // Events List

                StreamBuilder(
                  stream: FirestoreServices.getEventsByDate(
                      "${selectedDate?.toLocal()}".split(' ')[0]),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("No Event Available"),
                      );
                    } else {
                      var data = snapshot.data!.docs;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return EventCard(
                                  isHovered: false,
                                  evTitle: "${data[index]['title']}",
                                  imgUrl: "${data[index]['image']}",
                                  evDate: "${data[index]['date']}",
                                );
                                // date: data[index]['date'],
                                // ),
                                // );
                              }),
                        ],
                      );
                    }
                  },
                ),
                // EventCard(
                //   evTitle: 'Fundraiser in WDC',
                //   imgUrl:
                //       'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                //   evDate: DateTime.now(),
                // ),
                // EventCard(
                //   evTitle: 'Fundraiser in WDC',
                //   imgUrl:
                //       'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                //   evDate: DateTime.now(),
                // ),
                // EventCard(
                //   evTitle: 'Fundraiser in WDC',
                //   imgUrl:
                //       'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                //   evDate: DateTime.now(),
                // ),
                // EventCard(
                //   evTitle: 'Fundraiser in WDC',
                //   imgUrl:
                //       'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
                //   evDate: DateTime.now(),
                // ),
                // EventCard(subject: 'Fundraiser in WDC'),
                // EventCard(subject: 'Fundraiser in LA'),
                // EventCard(subject: 'Fundraiser in Vegas'),
                // EventCard(subject: 'Fundraiser in UK'),
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Container(
    //         decoration: const BoxDecoration(
    //           gradient: LinearGradient(
    //             begin: Alignment(0, -1),
    //             end: Alignment(0, 1),
    //             colors: <Color>[
    //               Color(0xff033f50),
    //               Color(0xc9155465),
    //               Color(0xd0135163),
    //               Color(0x6c35778a),
    //               Color(0x6d357789),
    //               Color(0x45204853),
    //               Color(0x45428699),
    //               Color(0x005aa0b4),
    //             ],
    //             stops: <double>[0, 0.143, 0.286, 0.429, 0.571, 0.714, 0.857, 1],
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 17 * fem,
    //         top: 61.5 * fem,
    //         child: Align(
    //           child: SizedBox(
    //             width: 343 * fem,
    //             height: 48 * fem,
    //             child: Text(
    //               'Upcoming Events',
    //               style: TextStyle(
    //                 fontFamily: 'Inter',
    //                 fontSize: 39 * ffem,
    //                 fontWeight: FontWeight.w900,
    //                 height: 1.2125 * ffem / fem,
    //                 color: Color(0xffffffff),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 17 * fem,
    //         top: 144.5 * fem,
    //         child: Align(
    //           child: SizedBox(
    //             width: 124 * fem,
    //             height: 37 * fem,
    //             child: Text(
    //               'January',
    //               style: TextStyle(
    //                 fontFamily: 'Inter',
    //                 fontSize: 30 * ffem,
    //                 fontWeight: FontWeight.w900,
    //                 height: 1.2125 * ffem / fem,
    //                 color: Color(0xffffffff),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 17 * fem,
    //         top: 190 * fem,
    //         child: Container(
    //           width: 362 * fem,
    //           height: 79 * fem,
    //           child: ListView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount: 7,
    //             itemBuilder: (context, index) {
    //               // Determine the day name based on the index (0 is Sunday, 1 is Monday, etc.)
    //               String dayName =
    //                   ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][index];
    //
    //               // Check if it's Tuesday and change the background color and text color
    //               Color bgColor =
    //                   dayName == 'Tue' ? Color(0xff8eb1bb) : Color(0xff335660);
    //               Color textColor =
    //                   dayName == 'Tue' ? Color(0xff335660) : Color(0xff8eb1bb);
    //
    //               return Container(
    //                 margin:
    //                     EdgeInsets.fromLTRB(0 * fem, 0 * fem, 9 * fem, 0 * fem),
    //                 width: 44 * fem,
    //                 height: double.infinity,
    //                 decoration: BoxDecoration(
    //                   color: bgColor,
    //                   borderRadius: BorderRadius.circular(9 * fem),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Color(0x3f000000),
    //                       offset: Offset(0 * fem, 4 * fem),
    //                       blurRadius: 2 * fem,
    //                     ),
    //                   ],
    //                 ),
    //                 child: Stack(
    //                   children: [
    //                     Positioned(
    //                       left: 9.5 * fem,
    //                       top: 44 * fem,
    //                       child: Align(
    //                         child: SizedBox(
    //                           width: 26 * fem,
    //                           height: 20 * fem,
    //                           child: Text(
    //                             dayName,
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                               fontFamily: 'Poppins',
    //                               fontSize: 13 * ffem,
    //                               fontWeight: FontWeight.w700,
    //                               height: 1.5 * ffem / fem,
    //                               color: textColor,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Positioned(
    //                       left: 11 * fem,
    //                       top: 11 * fem,
    //                       child: Align(
    //                         child: SizedBox(
    //                           width: 23 * fem,
    //                           height: 36 * fem,
    //                           child: Text(
    //                             (index + 1).toString(),
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(
    //                               fontFamily: 'Poppins',
    //                               fontSize: 24 * ffem,
    //                               fontWeight: FontWeight.w700,
    //                               height: 1.5 * ffem / fem,
    //                               color: textColor,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         ),
    //       ),
    //       // Add other widgets or Positioned elements as needed
    //       // Button
    //       Positioned(
    //         left: 17 * fem,
    //         top: 280 * fem, // Adjust the top position based on your layout
    //         child: ElevatedButton(
    //           onPressed: () {
    //             // Navigate to another screen or add your button click logic here
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => EventCreator()),
    //             );
    //           },
    //           style: ElevatedButton.styleFrom(
    //             padding: EdgeInsets.zero,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(23 * fem),
    //             ),
    //             elevation: 2 * fem,
    //             primary: Color(0xff335660),
    //           ),
    //           child: Container(
    //             width: 362 * fem, // Adjust the width based on your layout
    //             height: 61 * fem, // Adjust the height based on your layout
    //             child: Center(
    //               child: Text(
    //                 'Create an Event',
    //                 style: TextStyle(
    //                   fontFamily: 'Inter',
    //                   fontSize: 20 * ffem,
    //                   fontWeight: FontWeight.w900,
    //                   height: 1.2125 * ffem / fem,
    //                   color: Color(0xff8eb1bb),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: 20 * fem,
    //         top: 363.5 * fem,
    //         child: Align(
    //           child: SizedBox(
    //             width: 188 * fem,
    //             height: 37 * fem,
    //             child: Text(
    //               'Filter Events',
    //               style: TextStyle(
    //                 fontFamily: 'Inter',
    //                 fontSize: 30 * ffem,
    //                 fontWeight: FontWeight.w900,
    //                 height: 1.2125 * ffem / fem,
    //                 color: Color(0xffffffff),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       //add content after positioned (IMPORTANT)
    //       // 3 Boxes under the Filter Events (Event Filter Boxes)
    //       Positioned(
    //         // autogroupucamdGV (J1GeTAsDv6SqgmUkWKUcAM)
    //         left: 20 * fem,
    //         top: 414 * fem,
    //         child: Container(
    //           width: 355 * fem,
    //           height: 108 * fem,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Container(
    //                 // autogroup7esjY8Z (J1Gehact1UswLC1hDT7esj)
    //                 padding: EdgeInsets.fromLTRB(
    //                     17 * fem, 23 * fem, 17 * fem, 14.5 * fem),
    //                 width: 110 * fem,
    //                 height: double.infinity,
    //                 decoration: BoxDecoration(
    //                   color: Color(0xff335660),
    //                   borderRadius: BorderRadius.circular(23 * fem),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Color(0x3f000000),
    //                       offset: Offset(0 * fem, 4 * fem),
    //                       blurRadius: 2 * fem,
    //                     ),
    //                   ],
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       // groupRCM (148:156)
    //                       margin: EdgeInsets.fromLTRB(
    //                           0 * fem, 0 * fem, 0 * fem, 8.69 * fem),
    //                       width: 56 * fem,
    //                       height: 44.81 * fem,
    //                       child: Icon(
    //                         donateIcon,
    //                         size: 56 * fem,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     Center(
    //                       // fundraiservQ1 (148:167)
    //                       child: Text(
    //                         'Fundraiser',
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           fontFamily:
    //                               'Inter', // Use the desired font family
    //                           fontSize: 14 * ffem,
    //                           fontWeight: FontWeight.w900,
    //                           height: 1.2125 * ffem / fem,
    //                           color: Color(0xffffffff),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 12 * fem,
    //               ),
    //               Container(
    //                 // autogrouptbsf3Dj (J1Geok7H1SQTEjxqXiTBsf)
    //                 padding: EdgeInsets.fromLTRB(
    //                     33.58 * fem, 22.29 * fem, 29.29 * fem, 14.5 * fem),
    //                 width: 111 * fem,
    //                 height: double.infinity,
    //                 decoration: BoxDecoration(
    //                   color: Color(0xff335660),
    //                   borderRadius: BorderRadius.circular(23 * fem),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Color(0x3f000000),
    //                       offset: Offset(0 * fem, 4 * fem),
    //                       blurRadius: 2 * fem,
    //                     ),
    //                   ],
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       // bxpartyLCq (148:165)
    //                       margin: EdgeInsets.fromLTRB(
    //                           0 * fem, 0 * fem, 0 * fem, 6.08 * fem),
    //                       width: 48.13 * fem,
    //                       height: 48.13 * fem,
    //                       child: Icon(
    //                         partyHatIcon,
    //                         size: 48.13 * fem,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     Center(
    //                       // galaF4u (148:168)
    //                       child: Container(
    //                         margin: EdgeInsets.fromLTRB(
    //                             0 * fem, 0 * fem, 9.29 * fem, 0 * fem),
    //                         child: Text(
    //                           'Gala',
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontFamily:
    //                                 'Inter', // Use the desired font family
    //                             fontSize: 14 * ffem,
    //                             fontWeight: FontWeight.w900,
    //                             height: 1.2125 * ffem / fem,
    //                             color: Color(0xffffffff),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 12 * fem,
    //               ),
    //               Container(
    //                 // autogroupcjpp8uP (J1Geu5HjAon9DATicYCjPP)
    //                 padding: EdgeInsets.fromLTRB(
    //                     20.5 * fem, 23.25 * fem, 20.5 * fem, 14.5 * fem),
    //                 width: 110 * fem,
    //                 height: double.infinity,
    //                 decoration: BoxDecoration(
    //                   color: Color(0xff335660),
    //                   borderRadius: BorderRadius.circular(23 * fem),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Color(0x3f000000),
    //                       offset: Offset(0 * fem, 4 * fem),
    //                       blurRadius: 2 * fem,
    //                     ),
    //                   ],
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       // carboneventsESd (148:163)
    //                       margin: EdgeInsets.fromLTRB(
    //                           0 * fem, 0 * fem, 0 * fem, 7.75 * fem),
    //                       width: 48.75 * fem,
    //                       height: 45.5 * fem,
    //                       child: Icon(
    //                         groupIcon,
    //                         size: 48.75 * fem,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     Center(
    //                       // programsYy7 (148:169)
    //                       child: Text(
    //                         'Programs',
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(
    //                           fontFamily:
    //                               'Inter', // Use the desired font family
    //                           fontSize: 14 * ffem,
    //                           fontWeight: FontWeight.w900,
    //                           height: 1.2125 * ffem / fem,
    //                           color: Color(0xffffffff),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       //Event Text under Filter Event boxes
    //       Positioned(
    //         left: 26 * fem,
    //         top: 543.5 * fem,
    //         child: Align(
    //           child: SizedBox(
    //             width: 104 * fem,
    //             height: 37 * fem,
    //             child: Text(
    //               'Events',
    //               style: TextStyle(
    //                 fontFamily: 'Inter',
    //                 fontSize: 30 * ffem,
    //                 fontWeight: FontWeight.w900,
    //                 height: 1.2125 * ffem / fem,
    //                 color: Color(0xffffffff),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       // Events boxes underneath the Event test (MAIN ITEMS)
    //       Positioned(
    //         left: 20 * fem,
    //         top: 602 * fem,
    //         child: ElevatedButton(
    //           onPressed: () {
    //             // Navigate to another screen or add your button click logic here
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => EventManagerInfo()),
    //             );
    //           },
    //           style: ElevatedButton.styleFrom(
    //             padding: EdgeInsets.zero,
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(23 * fem),
    //             ),
    //             elevation: 2 * fem,
    //             primary: Color(0xff335660),
    //           ),
    //           child: Container(
    //             padding:
    //                 EdgeInsets.fromLTRB(22.97 * fem, 0 * fem, 0 * fem, 0 * fem),
    //             width: 355 * fem,
    //             height: 107 * fem,
    //             decoration: BoxDecoration(
    //               color: Color(0xff335660),
    //               borderRadius: BorderRadius.circular(23 * fem),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Color(0x3f000000),
    //                   offset: Offset(0 * fem, 4 * fem),
    //                   blurRadius: 2 * fem,
    //                 ),
    //               ],
    //             ),
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Container(
    //                   margin: EdgeInsets.fromLTRB(
    //                       0 * fem, 18.5 * fem, 11 * fem, 28.19 * fem),
    //                   width: 210.03 * fem,
    //                   height: double.infinity,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Container(
    //                         margin: EdgeInsets.fromLTRB(
    //                             0.03 * fem, 0 * fem, 0 * fem, 2 * fem),
    //                         child: Text(
    //                           'Fundraiser in Ohio Dr',
    //                           style: TextStyle(
    //                             fontFamily: 'Inter',
    //                             fontSize: 20 * ffem,
    //                             fontWeight: FontWeight.w900,
    //                             height: 1.2125 * ffem / fem,
    //                             color: Color(0xff8eb1bb),
    //                           ),
    //                         ),
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(
    //                             top: 2.69 * fem), // Adjusted margin
    //                         child: Row(
    //                           children: [
    //                             Icon(
    //                               Icons.calendar_today,
    //                               color: Color(0xffffffff),
    //                               size: 11 * ffem,
    //                             ),
    //                             SizedBox(width: 5 * fem),
    //                             Text(
    //                               'Jan 12, 2024',
    //                               style: TextStyle(
    //                                 fontFamily: 'Inter',
    //                                 fontSize: 11 * ffem,
    //                                 fontWeight: FontWeight.w900,
    //                                 height: 1.2125 * ffem / fem,
    //                                 color: Color(0xffffffff),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Container(
    //                         margin: EdgeInsets.only(
    //                             right: 7 * fem), // Adjusted margin
    //                         width: double.infinity,
    //                         child: Row(
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Icon(
    //                               Icons.location_on,
    //                               color: Color(0xffffffff),
    //                               size: 11 * ffem,
    //                             ),
    //                             SizedBox(width: 5 * fem),
    //                             Text(
    //                               'Greenfields, Sector 101, Forbibad',
    //                               style: TextStyle(
    //                                 fontFamily: 'Inter',
    //                                 fontSize: 11 * ffem,
    //                                 fontWeight: FontWeight.w900,
    //                                 height: 1.2125 * ffem / fem,
    //                                 color: Color(0xffffffff),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   width: 111 * fem,
    //                   height: 107 * fem,
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(14 * fem),
    //                     child: Image.network(
    //                       'https://th.bing.com/th/id/OIG.6lEn_xIMmKLRHNJDOvCy?pid=ImgGn',
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         //Add more Event boxes below
    //       ),
    //     ],
    //   ),
    // );
  }
}

class FilterEventCats extends StatelessWidget {
  const FilterEventCats({
    super.key,
    required this.fem,
    required this.ffem,
    required this.name,
    required this.icon,
  });

  final double fem;
  final double ffem;
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // autogroup7esjY8Z (J1Gehact1UswLC1hDT7esj)
      padding: EdgeInsets.all(10.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // groupRCM (148:156)
            margin: EdgeInsets.all(8.0),
            child: Icon(
              icon,
              size: 56 * fem,
              color: Colors.white,
            ),
          ),
          Center(
            // fundraiservQ1 (148:167)
            child: Text(
              '$name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter', // Use the desired font family
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w900,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
