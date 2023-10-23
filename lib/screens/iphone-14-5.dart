import 'package:flutter/material.dart';

import 'iphone-14-6.dart';

class Scene3 extends StatefulWidget {
  @override
  State<Scene3> createState() => _Scene3State();
}

class _Scene3State extends State<Scene3> {
  List<bool> isCheckedList = [false, false, false, false]; // List of checkbox states

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        title: Text("Getting Started"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF044051),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(18 * fem, 115 * fem, 18 * fem, 200 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: <Color>[
                Color(0xFF044051),
                Color(0xFF447582),
                Color(0xFF3F7180),
                Color(0xFF99B8C1),
                Color(0xFFA6C2C9),
                Color(0xFFABC2C8),
                Color(0xFFC0CCD0),
                Color(0xFFBECDD1),
              ],
              stops: <double>[0, 0.143, 0.286, 0.429, 0.571, 0.714, 0.857, 1],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 42 * fem, 36 * fem),
                constraints: BoxConstraints(
                  maxWidth: 312 * fem,
                ),
                child: Text(
                  'What motivates you to improve',
                  style: TextStyle(
                    fontSize: 39 * ffem,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 32 * fem, 15 * fem),
                constraints: BoxConstraints(
                  maxWidth: 322 * fem,
                ),
                child: Text(
                  'We will make all the help personalized based on what you say!',
                  style: TextStyle(
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              // Checkbox 1
              Container(
                margin: EdgeInsets.all(8 * fem),
                decoration: BoxDecoration(
                  color: Color(0xff8eb1bb), // Background color
                  borderRadius: BorderRadius.circular(23 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: CheckboxListTile(
                  title: Text(
                    'I want to have fun with friends and family',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                  value: isCheckedList[0],
                  onChanged: (bool? newValue) {
                    setState(() {
                      isCheckedList[0] = newValue ?? false;
                    });
                  },
                ),
              ),
              // Checkbox 2
              Container(
                margin: EdgeInsets.all(8 * fem),
                decoration: BoxDecoration(
                  color: Color(0xff8eb1bb), // Background color
                  borderRadius: BorderRadius.circular(23 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: CheckboxListTile(
                  title: Text(
                    'I want to have fun with friends and family',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                  value: isCheckedList[1],
                  onChanged: (bool? newValue) {
                    setState(() {
                      isCheckedList[1] = newValue ?? false;
                    });
                  },
                ),
              ),
              // Checkbox 3
              Container(
                margin: EdgeInsets.all(8 * fem),
                decoration: BoxDecoration(
                  color: Color(0xff8eb1bb), // Background color
                  borderRadius: BorderRadius.circular(23 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: CheckboxListTile(
                  title: Text(
                    'I want to have fun with friends and family',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                  value: isCheckedList[2],
                  onChanged: (bool? newValue) {
                    setState(() {
                      isCheckedList[2] = newValue ?? false;
                    });
                  },
                ),
              ),
              // Checkbox 4
              Container(
                margin: EdgeInsets.all(8 * fem),
                decoration: BoxDecoration(
                  color: Color(0xff8eb1bb), // Background color
                  borderRadius: BorderRadius.circular(23 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0 * fem, 4 * fem),
                      blurRadius: 2 * fem,
                    ),
                  ],
                ),
                child: CheckboxListTile(
                  title: Text(
                    'I want to have fun with friends and family',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
                  ),
                  value: isCheckedList[3],
                  onChanged: (bool? newValue) {
                    setState(() {
                      isCheckedList[3] = newValue ?? false;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  // Add your navigation logic here to go to a different screen.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Scene4()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(87 * fem, 0 * fem, 122 * fem, 0 * fem),
                  width: double.infinity,
                  height: 49 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xff8eb1bb),
                    borderRadius: BorderRadius.circular(23 * fem),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3f000000),
                        offset: Offset(0 * fem, 4 * fem),
                        blurRadius: 2 * fem,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20 * ffem,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
