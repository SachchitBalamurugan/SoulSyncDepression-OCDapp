import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/utils.dart';
import '../screens/home_screen.dart';

class Scene extends StatefulWidget {
  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  bool isFetched = false;
  bool isOCD = true;
  List<Therapist> therapistResults = [];

  @override
  void initState() {
    super.initState();
    fetchNearbyTherapists('OCD  therapist');
  }

  Future<Position> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle permission denied, ask the user for permission.
        return Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 0.0, altitude: 0, altitudeAccuracy: 0.0, heading: 0, headingAccuracy: 0.0, speed: 0.0, speedAccuracy: 0.0);
      }
      if (permission == LocationPermission.deniedForever) {
        // Handle permission denied forever, show a message to the user.
        return Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 0.0, altitude: 0, altitudeAccuracy: 0.0, heading: 0, headingAccuracy: 0.0, speed: 0.0, speedAccuracy: 0.0);
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position;
    } catch (e) {
      // Handle any errors that occur during location fetching.
      print("Error: $e");
      return Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 0.0, altitude: 0, altitudeAccuracy: 0.0, heading: 0, headingAccuracy: 0.0, speed: 0.0, speedAccuracy: 0.0);
    }
  }


  Future<void> fetchNearbyTherapists(String keyword) async {
    Position position = await getCurrentLocation();
    if(position.latitude != 0 && position.longitude!=0){
    String apiKey = 'AIzaSyARs-KUVewYORXDTiNOoomn3bQj3bzAYYQ';
    double userLatitude = position.latitude;
    double userLongitude = position.longitude; 

    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$userLatitude,$userLongitude&radius=5000&keyword=$keyword&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if(mounted){
        setState(() {
        therapistResults = 
        List<Therapist>.from(data['results'].map((therapistData) {
        return Therapist(
          name: therapistData['name'],
          vicinity: therapistData['vicinity'],
        );
      }));
      isFetched = true;
      });
      }
    } else {
      setState(() {
        isFetched = false;
      });
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
    body: Container(
        padding: EdgeInsets.fromLTRB(18*fem, 48.5*fem, 11*fem, 0*fem),
        width: double.infinity,
        decoration: const BoxDecoration (
          color: Color(0xffffffff),
          gradient: LinearGradient (
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xff033f50), Color(0xc9155465), Color(0xd0135163), Color(0x6c35778a), Color(0x6d357789), Color(0x45204853), Color(0x45428699), Color(0x005aa0b4)],
            stops: <double>[0, 0.143, 0.286, 0.429, 0.571, 0.714, 0.857, 1],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 34.5*fem),
              child: Text(
                'Therapy',
                style: SafeGoogleFont (
                  'Inter',
                  fontSize: 39*ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.2125*ffem/fem,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
            Text("Your Nearby Therapists", style: SafeGoogleFont(
                        'Livvic',
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.255 * ffem / fem,
                        color: const Color(0xffffffff),
                      ),),
                      const SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.fromLTRB(3 * fem, 0 * fem, 30 * fem, 30 * fem),
              width: double.infinity,
              height: 34 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      fetchNearbyTherapists("OCD Therapists");
                      setState(() {
                        isOCD = true;
                        isFetched = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOCD? const Color(0xff60828b): const Color(0xff8eb1bb),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23 * fem),
                      ),
                      elevation: 4, // Adjust the elevation as needed
                    ),
                    child: Text(
                      'OCD',
                      style: SafeGoogleFont(
                        'Livvic',
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.255 * ffem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  SizedBox(width: 24 * fem), // Adjust the width as needed for spacing
                  ElevatedButton(
                    onPressed: () {
                      fetchNearbyTherapists("Depression Therapists");
                      setState(() {
                        isOCD = false;
                        isFetched = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isOCD? const Color(0xff8eb1bb):const Color(0xff60828b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23 * fem),
                      ),
                      elevation: 4, // Adjust the elevation as needed
                    ),
                    child: Text(
                      'Depression',
                      style: SafeGoogleFont(
                        'Livvic',
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.255 * ffem / fem,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //    margin: EdgeInsets.fromLTRB(0*fem, 20, 0, 20),
            //    padding: const EdgeInsets.fromLTRB(05, 10, 05, 10),
            //   width: double.infinity,
            //   decoration: BoxDecoration (
            //     color: const Color(0xff8eb1bb),
            //     borderRadius: BorderRadius.circular(23*fem),
            //     boxShadow: [
            //       BoxShadow(
            //         color: const Color(0x3f000000),
            //         offset: Offset(0*fem, 4*fem),
            //         blurRadius: 2*fem,
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Container(
            //         // materialsymbolssearchwGT (105:100)
            //         margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 18.5 * fem, 0 * fem),
            //         width: 33 * fem,
            //         height: 33 * fem,
            //         child: Icon(
            //           Icons.search, // Use the search icon
            //           size: 33 * fem,
            //           color: Colors.white70, // Set the color of the icon as needed
            //         ),
            //       ),
            //       Text(
            //         // filterbylocation3qH (105:99)
            //         'Filter by location',
            //         style: SafeGoogleFont (
            //           'Livvic',
            //           fontSize: 20*ffem,
            //           fontWeight: FontWeight.w600,
            //           height: 1.255*ffem/fem,
            //           color: const Color(0x7fffffff),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            isFetched?
            Expanded(
              child: ListView.builder(
                itemCount: therapistResults.length,
                 itemBuilder: (context, index) {
                  var therapist = therapistResults[index];
                  
                    if(therapistResults.isNotEmpty){
                      return Container(
                  margin: EdgeInsets.fromLTRB(3*fem, 0*fem, 0*fem, 17*fem),
                  width: 358*fem,
                  height: 136*fem,
                  child: Stack(
                    children: [
                      Positioned(
                        // rectangle16VSP (105:97)
                        left: 0*fem,
                        top: 0*fem,
                        child: Align(
                          child: SizedBox(
                            width: 353*fem,
                            height: 126*fem,
                            child: Container(
                              decoration: BoxDecoration (
                                borderRadius: BorderRadius.circular(23*fem),
                                color: const Color(0xff8eb1bb),
                                //image: const DecorationImage(image: AssetImage("images/apple.png")),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x3f000000),
                                    offset: Offset(0*fem, 4*fem),
                                    blurRadius: 2*fem,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // sachchitbalamurugan1dagox55 (105:95)
                        left: 96*fem,
                        top: 16.5*fem,
                        child: Align(
                          child: SizedBox(
                            width: 225*fem,
                            height: 19*fem,
                            child: Text(
                              therapist.name,
                              style: SafeGoogleFont (
                                'Livvic',
                                fontSize: 15*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.255*ffem/fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // professionalocdtherapistmckinn (105:104)
                        left: 96*fem,
                        top: 34*fem,
                        child: Align(
                          child: SizedBox(
                            width: 191*fem,
                            height: 38*fem,
                            child: Text(
                              therapist.vicinity,
                              style: SafeGoogleFont (
                                'Livvic',
                                fontSize: 15*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.255*ffem/fem,
                                color: const Color(0xb2ffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // ellipse8ueX (105:96)
                        left: 13*fem,
                        top: 14*fem,
                        child: Align(
                          child: SizedBox(
                            width: 64*fem,
                            height: 64*fem,
                            child: Container(
                              decoration: BoxDecoration (
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(32*fem),
                                // image: DecorationImage(image: NetworkImage(
                                //   "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${therapist.photoReferences}&key=AIzaSyARs-KUVewYORXDTiNOoomn3bQj3bzAYYQ"
                                //   ))// here should be the image
                              ),
                              child: Image.asset("images/therapist.png", height: 30, width:30),
                            ),
                          ),
                        ),
                      ),
                  
                    ],
                  ),
                );
                    }else{
                      return const Center(
                        child: Text("No Therapists in your place"),
                      );
                    }
                 },
              ),
            ): const Center(child: CircularProgressIndicator(),)
            
          ],
        ),
      )
    );
  }
}

class Therapist {
  final String name;
  final String vicinity;
  //final String description;
  //final String photoReferences;

  Therapist({
    required this.name,
    required this.vicinity,
    // required this.description,
    //required this.photoReferences,
  });
}
