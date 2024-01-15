import 'package:SoulSync/screens/event_details_screen.dart';
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
  late String daydate = '01';
  late String day = 'sat';

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
        day = DateFormat.E().format(selectedDate!);
        daydate = DateFormat.d().format(selectedDate!);
      });
    }
    print(selectedDate);
  }

  final double fem = 1.0;
  // Replace with your fem value
  final double ffem = 1.0;
  // Replace with your ffem value
  bool isHovered = false;

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
                                      day,
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
                                      // (index + 1).toString(),
                                      daydate,
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
                // Filter Events
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
                          // New
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              // NEW FUNCTIONS
                              void viewEventDetails(int index) {
                                // Access event details from data[index] and navigate to a details screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailsScreen(
                                        eventData: data[index]),
                                  ),
                                );
                              }

                              // NEW FUNCTIONS

                              return GestureDetector(
                                onTap: () => viewEventDetails(index),
                                child: EventCard(
                                  isHovered: false,
                                  // new inputs
                                  id: data[index].id,
                                  onDeletePressed: () {},
                                  onViewPressed: () {},
                                  //
                                  evTitle: "${data[index]['title']}",
                                  imgUrl: "${data[index]['image']}",
                                  evDate: "${data[index]['date']}",
                                  // date: data[index]['date'],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
