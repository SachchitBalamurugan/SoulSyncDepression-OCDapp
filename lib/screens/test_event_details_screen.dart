import 'package:SoulSync/consts/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen(
      {Key? key, required QueryDocumentSnapshot<Object?> eventData})
      : super(key: key);
  // uploadEvent() async {
  //   if (_formkey.currentState!.validate()) {
  //     String imageUrl = await _uploadEventBannerToStorage(_image!);
  //
  //     await _firestore.collection('events').doc(fileName).set({
  //       'image': imageUrl,
  //       'title': titleText, // Variable to store the title text
  //       'eventInfo': eventInfoText, // Variable to store the event info text
  //       'sponsors/specialGuests': sponsors,
  //       'date': "${selectedDate!.toLocal()}".split(' ')[0],
  //       'added_by': currentUser!.uid,
  //     }).whenComplete(() {
  //       setState(() {
  //         _image = null;
  //         _formkey.currentState!.reset();
  //       });
  //     });
  //   } else {
  //     print('O bad guy');
  //   }
  // }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Event Details'),
      // ),
      body: Container(
        // padding: EdgeInsets.all(15),
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
                Container(
                  padding: EdgeInsets.all(15.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.grey, // Set the default background color here
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(
                              context); // Navigate back when the back button is pressed
                        },
                      ),
                      //
                      Text(
                        'Event Title',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 39,
                          fontWeight: FontWeight.w900,
                          height: 1.2125,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Container(
                        child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/depression-8d67c.appspot.com/o/EventImages%2F5f34b96a-030c-4e71-994b-a5110e8af6fd?alt=media&token=b53b3ce2-9ef4-48ca-930d-e593d47d62a3',
                            fit: BoxFit.cover),
                      ),
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.location_on,
                      //       color: Colors.white,
                      //       size: 24 * fem,
                      //     ),
                      //     Text(
                      //       'Choose location...',
                      //       style: TextStyle(
                      //         fontFamily:
                      //             'Inter', // You can specify the font family here
                      //         fontSize: 17 * ffem,
                      //         fontWeight: FontWeight.w900,
                      //         height: 1.2125 * ffem / fem,
                      //         color: Color(0xffffffff),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      //Attending
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Attending (Auto Updates)',
                            style: TextStyle(
                              fontFamily:
                                  'Inter', // You can specify the font family here
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              height: 1.2125,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // child: _image != null
                //     ? Image.memory(
                //         _image,
                //         fit: BoxFit.cover,
                //       )
                //     : null),

                // Event Info
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event Info
                      Text(
                        'Event info:',
                        style: TextStyle(
                          fontFamily:
                              'Inter', // You can specify the font family here
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          height: 1.2125,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Text(
                        'Info Text',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffffffff),
                        ),
                      ),
                      //Sponsors/Special Guests
                      Text(
                        'Sponsors/Special Guests:',
                        style: TextStyle(
                          fontFamily:
                              'Inter', // You can specify the font family here
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          height: 1.2125,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Text(
                        "Sponsors / Special Guests",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffffffff),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // uploadEvent();
                          // Navigate to another screen or add your button click logic here
                          // TODO: UNCOMMENT FOR OTHER FUNCTIONALITIES
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => LocationSelectionScreen()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          elevation:
                              0, // Set elevation to 0 as the shadow is provided by the Container
                          backgroundColor: Color(0xff7c98a1),
                        ),
                        child: Center(
                          child: Container(
                            width: 362, // Adjust the width based on your layout
                            height:
                                61, // Adjust the height based on your layout
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
