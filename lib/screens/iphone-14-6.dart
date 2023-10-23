import 'package:flutter/material.dart';
import '../screens/iphone-14-7.dart';

import '../widgets/utils.dart';

class Scene4 extends StatefulWidget {
  const Scene4({super.key});

  @override
  State<Scene4> createState() => _Scene4State();
}

class _Scene4State extends State<Scene4> {
  TextEditingController messageController = TextEditingController();
  List<String> savedMessages = [];

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Getting Started',
          style: TextStyle(
            fontSize: 20 * ffem,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF044051),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[
              Color(0xFF044051), // Transparent color with 100% opacity
              Color(0xFF447582), // Transparent color with 81.77% opacity
              Color(0xFF3F7180), // Transparent color with 81.77% opacity
              Color(0xFF99B8C1), // Transparent color with 42.5% opacity
              Color(0xFFA6C2C9), // Transparent color with 43.04% opacity
              Color(0xFFABC2C8), // Transparent color with 27.14% opacity
              Color(0xFFC0CCD0), // Transparent color with 42.5% opacity
              Color(0xFFBECDD1), // Fully opaque color
            ],
            stops: <double>[0, 0.143, 0.286, 0.429, 0.571, 0.714, 0.857, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18 * fem, 115 * fem, 35 * fem, 79 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 25 * fem, 47 * fem),
                  constraints: BoxConstraints(
                    maxWidth: 312 * fem,
                  ),
                  child: Text(
                    'What motivates you to improve',
                    style: TextStyle(
                      fontSize: 39 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.2125 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 139 * fem, 66 * fem),
                  child: Text(
                    'Write your goals below.',
                    style: TextStyle(
                      fontSize: 18 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.2125 * ffem / fem,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(19 * fem, 0 * fem, 0 * fem, 35 * fem),
                  width: 318 * fem,
                  height: 336 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23 * fem),
                    color: const Color(0xff8eb1bb),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x3f000000),
                        offset: Offset(0 * fem, 4 * fem),
                        blurRadius: 2 * fem,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16 * fem), // Add padding
                    child: Column(
                      children: [
                        TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message here',
                            filled: true,
                            fillColor: Colors.white, // Background color
                            contentPadding: EdgeInsets.all(12 * fem),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10 * fem),
                              borderSide: BorderSide.none, // Remove border
                            ),
                          ),
                        ),
                        SizedBox(height: 10 * fem), // Add some space
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              savedMessages.add(messageController.text);
                              messageController.clear();
                            });
                          },
                          style: ElevatedButton.styleFrom( // Customize button style
                            backgroundColor: const Color(0xff8eb1bb),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23 * fem),
                            ),
                            elevation: 2 * fem,
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.255 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        SizedBox(height: 10 * fem), // Add some space
                        // Display saved messages
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: savedMessages.length,
                          itemBuilder: (context, index) {
                            return Text(savedMessages[index],
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.2125 * ffem / fem,
                                color: const Color(0xffffffff),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5 * fem), // Add some space
                InkWell(
                  onTap: () {
                    // Add your navigation logic here to go to a different screen.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Scene5()),
                    );
                  },
                  child: Container(
                    // autogroupfexhAbh (EtRgitej7MTxLmb6p8fEXh)
                    margin: EdgeInsets.fromLTRB(31 * fem, 0 * fem, 10 * fem, 0 * fem),
                    width: double.infinity,
                    height: 49 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xff8eb1bb),
                      borderRadius: BorderRadius.circular(23 * fem),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3f000000),
                          offset: Offset(0 * fem, 4 * fem),
                          blurRadius: 2 * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Livvic',
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.255 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
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
