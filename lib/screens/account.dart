// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AccountScreen extends StatefulWidget {
  final String email;
  final String username;
  final String phone;
  const AccountScreen({super.key, required this.email, required this.username, required this.phone});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back),
    onPressed: () {
    Navigator.of(context).pop();
    },
    ),
    backgroundColor: Colors.transparent, // Set the AppBar background color to transparent
    elevation: 0, // Remove the shadow under the AppBar
    ),
    extendBodyBehindAppBar: true, // Extend the body behind the transparent AppBar
    body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: [
              Color(0xFF033F50),
              Color(0xC9155465),
              Color(0xD0135163),
              Color(0x6C35778A),
              Color(0x6D357789),
              Color(0x45204853),
              Color(0x45428699),
              Color(0x005AA0B4),
            ],
            stops: [0, 0.208, 0.208, 0.589, 0.76, 0.818, 0.849, 1],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 15, 70),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, bottom: 40),
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 39,
                        fontWeight: FontWeight.w900,
                        height: 1.2125,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAccountInfo('Name', widget.username),
                      _buildAccountInfo('Email', widget.email),
                      _buildAccountInfo('Phone', widget.phone),
                      _buildAccountInfo('Occupation', 'Software Engineer'),
                      ElevatedButton(
                        onPressed: () async{
                          await FirebaseAuth.instance.signOut();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          // Implement logout functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8EB1BB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.255,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
