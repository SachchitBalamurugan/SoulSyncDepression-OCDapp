// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/mood_tracker.dart';
import '../screens/registration_base.dart';
import '../widgets/bottomNavBar.dart';
import '../screens/mood_tracker.dart';
import 'forgot_pw_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Your logo goes here
                Container(
                  width: 150, // Adjust the width of the logo
                  height: 150, // Adjust the height of the logo
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the radius as needed
                    child: Image.asset(
                        'images/OCDappLogo.jpg'), // Replace 'your_logo.png' with your logo image path
                  ),
                ),
                const SizedBox(height: 24.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white), // Set the outline color to white
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white), // Set the outline color to white
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoodTrackerScreen()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('No user found for that email'),
                          duration: Duration(milliseconds: 300),
                        ));
                        print('No user found for that email');
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text('Wrong password provided for that user'),
                          duration: Duration(milliseconds: 300),
                        ));
                        print('Wrong password provided for that user');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("$e"),
                          duration: const Duration(milliseconds: 300),
                        ));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity,
                        48), // Set the minimum size (width and height) of the button
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0), // Set the vertical padding
                    textStyle:
                        const TextStyle(fontSize: 18), // Set the text font size
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                    onPressed: () {
                      // Navigate to the registration screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor:
                          Colors.black, // Set the text color to white
                    ),
                    child: const Text('Create an account')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
