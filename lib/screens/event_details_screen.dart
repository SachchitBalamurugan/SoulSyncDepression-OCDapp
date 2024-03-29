import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../consts/firebase_constants.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({Key? key, required this.eventData})
      : super(key: key);

  final DocumentSnapshot eventData;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String? fileName;

  final _uuid = Uuid();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bookEvent() async {
    fileName = _uuid.v4().toString();
    try {
      await _firestore.collection('bookedEvents').doc(fileName).set({
        'image': widget.eventData['image'],
        'title': widget.eventData['title'], // Variable to store the title text
        'date': widget.eventData['date'],
        'eventId': widget.eventData.id,
        'eventInfo': widget.eventData['eventInfo'],
        'specialGuests': widget.eventData['specialGuests'],
        'booked_by': currentUser!.uid,
      }).whenComplete(() {
        print('Event Booked');
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Event Booked!'),
            content: const Text(
              'Event Booked! Manage your events in Event Info Test',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.eventData.data();
    final map = data as Map<String, dynamic>;
    final bookedBy = map.containsKey('booked_by') ? data['booked_by'] : null;
    final location = map.containsKey('location') ? map['location'] : 'Unknown';

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
        child: CustomScrollView(
          primary: false,
          slivers: [
            // Header with image, title, others
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.eventData['image'],
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.eventData['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _onShare(map),
                            icon: const Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // date location attending
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, bottom: 15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                // Calendar Button

                                const Icon(
                                  Icons.event,
                                  color: Colors.white,
                                  size: 24,
                                ),

                                Text(
                                  widget.eventData['date'],
                                  // Display the hint text if no date is selected
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // location
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Text(
                                  location,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    // You can specify the font family here
                                    // fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w900,
                                    // height: 1.2125 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Attending
                          const Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: Colors.white,
                                // size: 24 * fem,
                              ),
                              Text(
                                'Attending (Auto Updates)',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  // You can specify the font family here
                                  // fontSize: 17 * ffem,
                                  fontWeight: FontWeight.w900,
                                  // height: 1.2125 * ffem / fem,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Event Info
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Event info:',
                      style: TextStyle(
                        // You can specify the font family here
                        fontFamily: 'Inter',
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        // height: 1.2125 * ffem / fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Text(
                      widget.eventData['eventInfo'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sponsors/Special Guests:',
                      style: TextStyle(
                        // You can specify the font family here
                        fontFamily: 'Inter',
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        height: 1.2125,
                        color: Color(0xffffffff),
                      ),
                    ),
                    Text(
                      widget.eventData['specialGuests'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // Book Event
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: bookedBy != null
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: () {
                          bookEvent();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          elevation: 0,
                          // Set elevation to 0 as the shadow is provided by the Container
                          backgroundColor: const Color(0xff7c98a1),
                        ),
                        child: const SizedBox(
                          width: 362,
                          height: 61,
                          child: Center(
                            child: Text(
                              'Book Event',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onShare(Map<String, dynamic> map) async {
    final imageUrl = map['image'];

    final uri = Uri.parse(imageUrl);
    final response = await http.get(uri);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/image.jpg');
    await file.writeAsBytes(response.bodyBytes);

    Share.shareXFiles(
      [XFile(file.path)],
      text:
          "${map['title']}\n${map['date']}\n${map['location']},\n${map['eventInfo']},\n${map['specialGuests']}",
    );
  }
}
