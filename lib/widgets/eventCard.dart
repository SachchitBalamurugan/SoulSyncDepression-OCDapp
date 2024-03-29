import 'dart:math';

import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  EventCard({
    super.key,
    required this.id,
    required this.onDeletePressed,
    required this.onViewPressed,
    required this.isHovered,
    required this.evTitle,
    required this.evDate,
    required this.imgUrl,
    this.location,
  });

  // new inputs
  final String id;
  final VoidCallback onDeletePressed;
  final VoidCallback onViewPressed;
  //

  final double fem = 1.0; // Replace with your fem value
  final double ffem = 1.0;
  final String evTitle;
  final String evDate;
  final String imgUrl;
  final String? location;
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    //--------------
    // Access hover state from parent widget;
    //-------------
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      width: double.infinity,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Color(0xff335660), borderRadius: BorderRadius.circular(10.0)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    insertNewlineAtWordBoundary(evTitle, 20),
                    // Apply a maximumLines and overflow property to handle the second line

                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.2125 * ffem / fem,
                      color: Color(0xff8eb1bb),
                    ),
                  ),
                  SizedBox(
                    height: 2.69 * fem,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Color(0xffffffff),
                        size: 11 * ffem,
                      ),
                      SizedBox(width: 5 * fem),
                      Text(
                        '$evDate',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11 * ffem,
                          fontWeight: FontWeight.w900,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                  // Show Location, if null/empty replace with Default Location
                  Text(
                    location ?? 'Greenfields, Sector 101, Forbibad',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11 * ffem,
                      fontWeight: FontWeight.w900,
                      height: 1.2125 * ffem / fem,
                      color: Color(0xffffffff),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 5 * fem),
              Container(
                width: 111 * fem,
                height: 107 * fem,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14 * fem),
                  child: Image.network(
                    '$imgUrl',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          //----------
          // HOVER EFFECT TO DELETE AND VIEW
          Visibility(
              visible: isHovered,
              child: Positioned.fill(
                  child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(0.3)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: onViewPressed,
                      child: Text('View Details'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(0.3)),
                        foregroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: onDeletePressed,
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ))),
          // Hover Effect
        ],
      ),
    );
  }

  String insertNewlineAtWordBoundary(String text, int maxLength) {
    if (text.length <= maxLength)
      return text; // No need to split if short enough

    final lastIndexFirstLine = text.lastIndexOf(' ', maxLength);
    final firstLine = text.substring(0, lastIndexFirstLine + 1);
    final remainingText = text.substring(lastIndexFirstLine + 1);
    if (remainingText.length <= maxLength) {
      // Second line fits within max length, no need to truncate
      return firstLine + '\n' + remainingText;
    }
    final lastIndexSecondLine = remainingText.lastIndexOf(' ', maxLength);
    return firstLine +
        '\n' +
        remainingText.substring(0, lastIndexSecondLine + 1) +
        '...';
  }
}
