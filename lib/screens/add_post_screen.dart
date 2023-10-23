// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoulSync/screens/community.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  static const routeName = "add-post";
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String profilePicLink = "";
  var _image;
  final _picker = ImagePicker();
  var userid = FirebaseAuth.instance.currentUser!.uid;
  var name = FirebaseAuth.instance.currentUser!.displayName;
  DateTime date = DateTime.now();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    Reference ref =
        FirebaseStorage.instance.ref().child("Profile Pic/${DateTime.now()}");
    _image = File(pickedImage!.path);
    await ref.putFile(_image);
    ref.getDownloadURL().then((value) async {
      setState(() {
        profilePicLink = value;
        print("this is photo link $value");
      });
    });
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  void Submit() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection("Social Posts").add({
        "name": name,
        "date": date,
        "likes": 0,
        "postText": _textController.text,
        "photoLink": profilePicLink,
        "likeList": []
      });
      Navigator.of(context).pop();
    }
  }

  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // SocialPost post
  // = SocialPost(
  //     userName: "Abd",
  //     likeList: [],
  //     date: Timestamp.fromDate(DateTime.now()),
  //     likes: 40,
  //     postText: "hey this is my plant, stasy",
  //     postId: DateTime.now().toString(),
  //     photo:
  //         "https://i.pinimg.com/originals/2b/2f/3b/2b2f3ba27ceb7cf7736e0071aaf8aefd.jpg", liked: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(children: [
            Form(
                key: _formKey,
                child: Column(children: [
                  heading("Write Your Story!"),
                  TextFormField(
                    controller: _textController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required!";
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.white,
                    decoration: textFeildDecoration(
                        "Explain your Story", Icons.emoji_emotions_outlined),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 228, 228, 228),
                    child: Center(
                      child: _image != null
                          ? Image.file(_image, fit: BoxFit.cover)
                          : TextButton(
                              onPressed: () {
                                _openImagePicker();
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select A Photo",
                                    style: TextStyle(color: Colors.blueGrey),
                                  ),
                                  Icon(
                                    Icons.image,
                                    color: Colors.blueGrey,
                                  )
                                ],
                              ),
                            ),
                    ),
                  )
                ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  //SocialPost post = SocialPost(userName: name.toString(), date:date as Timestamp, liked: true, postText:_textController.text, photo: _image, likes: 0, likeList: [], postId: '');
                  Submit();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[400],
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 60)),
                child: const Text(
                  "Share",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      )),
    );
  }

  Widget heading(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  InputDecoration textFeildDecoration(String hintText, IconData? icon) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(bottom: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.white,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Colors.white,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
