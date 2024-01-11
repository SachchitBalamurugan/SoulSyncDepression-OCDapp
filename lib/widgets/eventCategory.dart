import 'package:flutter/material.dart';

class EventCategory extends StatelessWidget {
  const EventCategory({
    super.key,
    required this.txt,
  });

  final double fem = 1.0; // Replace with your fem value
  final double ffem = 1.0;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        '$txt',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 30 * ffem,
          fontWeight: FontWeight.w900,
          height: 1.2125 * ffem / fem,
          color: Color(0xffffffff),
        ),
      ),
    );
  }
}
