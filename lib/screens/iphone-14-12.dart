import 'package:SoulSync/screens/event_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../consts/firestore_services.dart';
import '../widgets/eventCard.dart';
import '../widgets/eventCategory.dart';
import 'EventCreator.dart';

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
  final _dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final _searchController = TextEditingController();

  final double fem = 1.0;

  // Replace with your fem value
  final double ffem = 1.0;

  // Replace with your ffem value
  bool isHovered = false;

  var _selectedDate = DateTime.now();
  var _selectedSundayDate = DateTime.now().subtract(
    Duration(days: DateTime.now().weekday),
  );

  var _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchTextChange);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChange);

    super.dispose();
  }

  void _onSearchTextChange() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search events...",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(Icons.search, size: 25),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Open the date picker when the calendar icon is tapped
                      _selectDate(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff335660),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ), // Adjust the radius as needed
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: EventCategory(txt: _getMonth()),
                    ),
                  ),
                ),
                // Scrolling Days
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 80 * fem,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        // Determine the day name based on the index (0 is Sunday, 1 is Monday, etc.)
                        final dayName = _dayNames[index];
                        final currentDate = _selectedSundayDate.add(
                          Duration(days: index),
                        );
                        final date = DateFormat.d().format(currentDate);

                        // Check if it's Tuesday and change the background color and text color
                        final bgColor = dayName == 'Tue'
                            ? const Color(0xff8eb1bb)
                            : const Color(0xff335660);
                        final textColor = dayName == 'Tue'
                            ? const Color(0xff335660)
                            : const Color(0xff8eb1bb);

                        return GestureDetector(
                          onTap: () {
                            _onChangeDate(currentDate);
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                              0 * fem,
                              0 * fem,
                              10 * fem,
                              0 * fem,
                            ),
                            width: 44 * fem,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(9 * fem),
                              border: _selectedDate.copyWith(microsecond: 0) ==
                                      currentDate.copyWith(microsecond: 0)
                                  ? Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x3f000000),
                                  offset: Offset(0 * fem, 4 * fem),
                                  blurRadius: 2 * fem,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  date,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                                Text(
                                  dayName.substring(0, 1),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w700,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
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
                SizedBox(height: 8.0),
                // Events on The Day
                EventCategory(txt: 'Events'),
                // Events List

                StreamBuilder(
                  stream: FirestoreServices.getEventsByDate(
                      "${_selectedDate.toLocal()}".split(' ')[0]),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text("No Event Available"),
                      );
                    } else {
                      final data = snapshot.data!.docs;
                      final filteredData = data.where(
                        (element) {
                          return element['title']
                              .toString()
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase());
                        },
                      ).toList();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // New
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredData.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = filteredData[index];
                              final map = item.data() as Map<String, dynamic>;

                              return GestureDetector(
                                onTap: () => viewEventDetails(item),
                                child: EventCard(
                                  isHovered: false,
                                  // new inputs
                                  id: item.id,
                                  onDeletePressed: () {},
                                  onViewPressed: () {},
                                  //
                                  evTitle: "${item['title']}",
                                  imgUrl: "${item['image']}",
                                  evDate: "${item['date']}",
                                  location: map.containsKey('location')
                                      ? "${item['location']}"
                                      : null,
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

  String _getMonth() {
    return DateFormat.MMMM().format(_selectedDate);
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      _searchController.text = '';

      setState(() {
        _selectedDate = picked;
        _selectedSundayDate = _selectedDate.subtract(
          Duration(days: _selectedDate.weekday),
        );
      });
    }
  }

  void _onChangeDate(DateTime picked) {
    _searchController.text = '';

    setState(() {
      _selectedDate = picked;
    });
  }

  void viewEventDetails(QueryDocumentSnapshot data) {
    // Access event details from data[index] and navigate to a details screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailsScreen(eventData: data),
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
