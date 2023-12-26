import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import 'MapScreen.dart';

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectLocation(context),
              child: Text('Select Location'),
            ),
            SizedBox(height: 20),
            PositionedLocationText(controller: locationController),
          ],
        ),
      ),
    );
  }

  Future<void> _selectLocation(BuildContext context) async {
    LatLng? selectedLatLng = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(),
      ),
    );

    if (selectedLatLng != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedLatLng.latitude,
        selectedLatLng.longitude,
      );

      Placemark placemark = placemarks.first;

      setState(() {
        locationController.text =
        'Selected Location: ${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}';
      });
    }
  }
}

class PositionedLocationText extends StatelessWidget {
  final TextEditingController controller;

  PositionedLocationText({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              controller.text,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Your MapScreen widget and other code...
