import 'dart:io'; // Add this import for File class
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import '../consts/firebase_constants.dart';
import '../widgets/eventCard.dart';
import '../widgets/eventCategory.dart';
import 'home_screen.dart';
import 'iphone-14-12.dart';
import 'location_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class EventCreator extends StatefulWidget {
  @override
  State<EventCreator> createState() => _EventCreatorState();
}

class _EventCreatorState extends State<EventCreator> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final double fem = 1.0;
  final double ffem = 1.0;

  // Variable to store the selected date
  PlatformFile? _image; // Variable to store the selected image file
  String? fileName;
  late String titleText; // Variable to store the title text
  late String eventInfoText; // Variable to store the event info text
  late String sponsors;
  String _location = '';
  DateTime? selectedDate;
  final _uuid = Uuid();

  CustomProgressDialog? _progressDialog;

  Future _pickImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      _image = result.files.first;
    });
  }

  _uploadEventBannerToStorage(PlatformFile image) async {
    fileName = _uuid.v4().toString();
    final path = 'EventImages/${_image?.path?.split('/').lastOrNull}';
    final file = File(_image!.path!);
    Reference ref = _storage.ref().child(path);
    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  uploadEvent() async {
    showLoadingDialog();

    // --------------------------------
    try {
      if (_formkey.currentState!.validate()) {
        String imageUrl = await _uploadEventBannerToStorage(_image!);

        await _firestore.collection('events').doc(fileName).set({
          'image': imageUrl,
          'title': titleText, // Variable to store the title text
          'eventInfo': eventInfoText, // Variable to store the event info text
          'specialGuests': sponsors,
          'location': _location,
          'date': "${selectedDate!.toLocal()}".split(' ')[0],
          'added_by': currentUser!.uid,
        }).whenComplete(() {
          setState(() {
            _image = null;
            selectedDate = null;
            _formkey.currentState!.reset();
          });
        });

        _onEventCreated();
      } else {
        print('O bad guy');
      }
    } catch (error) {
      _onFailedToCreateEvent(error);
    }
    //--------------------------------------------
  }

  void _onEventCreated() {
    hideLoadingDialog();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Event created!'),
        content: const Text(
          'Congratulation!\n Manage your events in Event Info Test',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onFailedToCreateEvent(dynamic error) {
    hideLoadingDialog();

    // Handle any errors that occur during deletion
    print(error);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to create event')),
    );
  }

// Future<void>
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _progressDialog?.dismiss();
    _progressDialog = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color:
                          Colors.grey, // Set the default background color here
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(
                                context); // Navigate back when the back button is pressed
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            titleText = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Event Title Must Not be empty';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 39,
                            fontWeight: FontWeight.w900,
                            height: 1.2125,
                            color: Color(0xffffffff),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Type your title here...',
                            hintStyle: TextStyle(
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        if (_image != null)
                          Container(
                            color: Colors.blue[100],
                            child: Center(
                              child: Text(_image!.name),
                            ),
                          ),
                        // Upload Icon
                        IconButton(
                          iconSize: 102 * fem,
                          icon: Icon(
                            Icons.upload,
                          ),
                          color: Colors.white,
                          onPressed: () async {
                            _pickImage(); // Open the image picker when the upload icon is tapped
                          },
                        ),
                        // Select the date
                        GestureDetector(
                          onTap: () {
                            // Open the date picker when the calendar icon is tapped
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              // Calendar Button
                              Icon(
                                Icons.event,
                                color: Colors.white,
                                size: 24 * fem,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  selectedDate != null
                                      ? "${selectedDate!.toLocal()}".split(
                                          ' ')[0] // Display the selected date
                                      : 'Select date',
                                  // Display the hint text if no date is selected
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Choose Location
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 24 * fem,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  _location = value;
                                },
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffffffff),
                                ),
                                // Allow the text field to take as much vertical space as needed
                                decoration: const InputDecoration(
                                  hintText: 'Input the location',
                                  hintStyle: TextStyle(
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        //Attending
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 24 * fem,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Attending (Auto Updates)',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                // You can specify the font family here
                                fontSize: 17 * ffem,
                                fontWeight: FontWeight.w900,
                                height: 1.2125 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

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
                            fontFamily: 'Inter',
                            // You can specify the font family here
                            fontSize: 30 * ffem,
                            fontWeight: FontWeight.w900,
                            height: 1.2125 * ffem / fem,
                            color: Color(0xffffffff),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            eventInfoText = value;
                          },
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                          ),
                          // Allow the text field to take as much vertical space as needed
                          decoration: InputDecoration(
                            hintText: 'Type your text here...',
                            hintStyle: TextStyle(
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        //Sponsors/Special Guests
                        Text(
                          'Sponsors/Special Guests:',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            // You can specify the font family here
                            fontSize: 30 * ffem,
                            fontWeight: FontWeight.w900,
                            height: 1.2125 * ffem / fem,
                            color: Color(0xffffffff),
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            sponsors = value;
                          },
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffffffff),
                          ),
                          // Allow the text field to take as much vertical space as needed
                          decoration: InputDecoration(
                            hintText: 'Type your text here...',
                            hintStyle: TextStyle(
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            uploadEvent();
                            // Navigate to another screen or add your button click logic here
                            // TODO: UNCOMMENT FOR OTHER FUNCTIONALITIES
                            //
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23 * fem),
                            ),
                            elevation: 0,
                            // Set elevation to 0 as the shadow is provided by the Container
                            backgroundColor: Color(0xff7c98a1),
                          ),
                          child: Center(
                            child: Container(
                              width: 362 *
                                  fem, // Adjust the width based on your layout
                              height: 61 *
                                  fem, // Adjust the height based on your layout
                              child: Center(
                                child: Text(
                                  'Create an Event',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 20 * ffem,
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
      ),
    );
  }

  void showLoadingDialog({
    bool isDismissible = true,
  }) {
    _progressDialog = CustomProgressDialog(
      context,
      dismissable: isDismissible,
    );
    _progressDialog?.setLoadingWidget(const CircularProgressIndicator());

    _progressDialog?.show();
  }

  void hideLoadingDialog() {
    _progressDialog?.dismiss();
  }
}
