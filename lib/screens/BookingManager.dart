import 'package:SoulSync/screens/event_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

class BookingManager extends StatefulWidget {
  @override
  State<BookingManager> createState() => _BookingManagerState();
}

class _BookingManagerState extends State<BookingManager> {
  bool isHovered = false;
// Replace with your ffem value

  //

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
                    'Manage your \nEvents!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 39,
                      fontWeight: FontWeight.w900,
                      height: 1.2125,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),

                // Booked Events
                EventCategory(txt: 'Booked'),
                StreamBuilder(
                  stream:
                      FirestoreServices.getUserBookedEvents(currentUser!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("You Haven't Booked any Event"),
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
                                print("your Booked events ${data[index]}");
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

                                void deleteEvent(int index) async {
                                  try {
                                    await FirestoreServices.deleteBookedEvent(
                                        data[index].id);
                                    setState(() =>
                                        data.removeAt(index)); // Update UI

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Event deleted')),
                                    );
                                  } catch (error) {
                                    // Handle any errors that occur during deletion
                                    print(error);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Failed to delete event')),
                                    );
                                  }
                                }

                                // NEW  NEW FUNCTIONS
                                return MouseRegion(
                                  onHover: (event) {
                                    setState(() {
                                      isHovered = true;
                                    });
                                    // Handle hover state changes (as discussed previously)
                                  },
                                  onExit: (event) {
                                    setState(() => isHovered = false);
                                  },
                                  child: EventCard(
                                    isHovered: isHovered,
                                    // new inputs
                                    id: data[index].id,
                                    onDeletePressed: () => deleteEvent(index),
                                    onViewPressed: () =>
                                        viewEventDetails(index),
                                    //
                                    evTitle: "${data[index]['title']}",
                                    imgUrl: "${data[index]['image']}",
                                    evDate: "${data[index]['date']}",
                                    // date: data[index]['date'],
                                  ),
                                );
                              }),
                        ],
                      );
                    }
                  },
                ),

                // Your Events
                EventCategory(txt: 'Your Events'),
                StreamBuilder(
                  stream: FirestoreServices.getUserEvents(currentUser!.uid),
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
                                print("your events ${data[index]}");
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

                                void deleteEvent(int index) async {
                                  try {
                                    await FirestoreServices.deleteEvent(
                                        data[index].id);
                                    setState(() =>
                                        data.removeAt(index)); // Update UI

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Event deleted')),
                                    );
                                  } catch (error) {
                                    // Handle any errors that occur during deletion
                                    print(error);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Failed to delete event')),
                                    );
                                  }
                                }
                                // NEW FUNCTIONS

                                return MouseRegion(
                                  onHover: (event) {
                                    setState(() {
                                      isHovered = true;
                                    });
                                    // Handle hover state changes (as discussed previously)
                                  },
                                  onExit: (event) {
                                    setState(() => isHovered = false);
                                  },
                                  child: EventCard(
                                    isHovered: isHovered,
                                    // new inputs
                                    id: data[index].id,
                                    onDeletePressed: () => deleteEvent(index),
                                    onViewPressed: () =>
                                        viewEventDetails(index),
                                    //
                                    evTitle: "${data[index]['title']}",
                                    imgUrl: "${data[index]['image']}",
                                    evDate: "${data[index]['date']}",
                                    // date: data[index]['date'],
                                  ),
                                );
                                // return EventCard(
                                //   evTitle: "${data[index]['title']}",
                                //   imgUrl: "${data[index]['image']}",
                                //   evDate: "${data[index]['date']}",
                                //   // date: data[index]['date'],
                                //   // ),
                                // );
                              }),
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
