import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RunningTrackerPage extends StatefulWidget {
  @override
  State<RunningTrackerPage> createState() => _RunningTrackerPageState();
}

class _RunningTrackerPageState extends State<RunningTrackerPage> {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  double depression = 0.0;
  double meditation = 0.0;
  double ocd = 0.0;
  double concentration = 0.0;
  bool dataDone = false;
  int check = 0;
  @override
  void initState() {
    super.initState();
  }


Future<double> fetchDocumentsAndCalculateAverage(String userId, String fieldName, int totalCourses) async {
  try {
    // Reference to the Firestore collection
    CollectionReference courseCollection = FirebaseFirestore.instance.collection('courses');

    // Query to fetch all documents in the subcollection
    QuerySnapshot querySnapshot = await courseCollection.doc(userId).collection(fieldName).get();

    // Initialize variables to calculate the sum and count
    double sum = 0;

    // Iterate through the documents
    querySnapshot.docs.forEach((doc) {
      // Assuming 'Points' field is numeric, you may need to adjust this based on your data
      bool points = doc['Points'] ?? false;
      if (points) {
        sum += 1.0; // Increment the sum by 1 for each 'true' value in 'Points' field
      }
    });

    // Calculate the average
    double average = totalCourses > 0 ? sum / totalCourses : 0.0;

    // Return the average
    return average;
  } catch (e) {
    print('Error fetching documents and calculating average: $e');
    return 0.0; // Return a default value or handle the error as needed
  }
}


  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) async{
           concentration = await fetchDocumentsAndCalculateAverage(userId,"Concentration",5);
           depression = await fetchDocumentsAndCalculateAverage(userId,"Depression",9);
           meditation = await fetchDocumentsAndCalculateAverage(userId,"Meditation",11);
           ocd = await fetchDocumentsAndCalculateAverage(userId,"OCD",10);
           if(mounted){
            setState(() {
             dataDone = true;
           });
           }
           
            });
      check++;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: _buildCustomAppBar(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [
              Color(0xff033f50),
              Color(0xc9155465),
              Color(0xd0135163),
              Color(0x6c35778a),
              Color(0x6d357789),
              Color(0x45204853),
              Color(0x45428699),
              Color(0x005aa0b4)
            ],
            stops: [0, 0.208, 0.208, 0.589, 0.76, 0.818, 0.849, 1],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: dataDone
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildProgressIndicator(
                          'OCD Course', Colors.white, ocd),
                      const SizedBox(height: 16),
                      _buildProgressIndicator(
                          'Depression Course', Colors.white, depression),
                      const SizedBox(height: 16),
                      _buildProgressIndicator('Concentration Course',
                          Colors.white, concentration),
                      const SizedBox(height: 16),
                      _buildProgressIndicator(
                          'Meditation Course', Colors.white, meditation),
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return AppBar(
      title: const SizedBox.shrink(),
      centerTitle: true,
      backgroundColor: const Color(0xFF0C3C49),
      elevation: 50,
      flexibleSpace: const Center(
        child: Text(
          'Course Progress',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Widget _buildProgressIndicator(String label, Color color, double progress) {
  return Column(
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        width: 200,
        height: 200,
        child: CustomPaint(
          painter: CircleProgressPainter(
            progress: progress,
            progressColor: color,
            backgroundColor: const Color(0xFF2E6270),
            strokeWidth: 20,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Center(
            child: Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final TextStyle textStyle;

  CircleProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;
    final startAngle = -90.0;
    final sweepAngle = 360.0 * progress;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      radians(startAngle),
      radians(sweepAngle),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.textStyle != textStyle;
  }
}

double radians(double degrees) {
  return degrees * (3.141592653589793) / 180;
}

void main() {
  runApp(MaterialApp(
    home: RunningTrackerPage(),
  ));
}
