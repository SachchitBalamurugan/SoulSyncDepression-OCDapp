import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(padding: EdgeInsets.only(top: 20),
    child: Column(
        children: [
          Text("The Mindful Wellness course is a comprehensive and transformative program designed to provide participants with valuable insights and practical tools to enhance their mental well-being. This course focuses on four critical areas: Concentration, Depression, Obsessive-Compulsive Disorder (OCD), and Meditation. Through a combination of theoretical knowledge, interactive exercises, and guided practices, participants will develop a deeper understanding of their minds and emotions, empowering them to lead a more balanced and fulfilling life."
          ,style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.7),
              ),
              textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Row(children: [
            Text("Course Length: ", style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
            ),
            Icon(
              Icons.timer,
              color: Color(0xFF674AEF),
            ),
            SizedBox(width: 5),
            Text("26 Hours", style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            ),
          ],
          ),
          SizedBox(height: 10),
          Row(children: [
            Text("Rating:", style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
            SizedBox(width: 5),
            Text("4.5", style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),)
          ],
          ),
        ],
    ),
    );
  }
}