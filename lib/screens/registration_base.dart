import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
          padding: EdgeInsets.all(16.0),
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
                SizedBox(height: 24.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white), // Set the outline color to white
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white), // Set the outline color to white
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white), // Set the outline color to white
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white), // Set the outline color to white
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.phone, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    CollectionReference userEntry =
                    FirebaseFirestore.instance.collection('users');
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.value.text,
                          password: passwordController.value.text);
                      await userEntry.doc(emailController.value.text).set({
                        'User Name': userNameController.text,
                        'Email': emailController.text,
                        'Phone': phoneController.text,
                      });
                      FirebaseAuth.instance.currentUser!.updateDisplayName(userNameController.text.trim());

                      Navigator.pop(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('The password provided is too weak.'),
                          duration: Duration(milliseconds: 300),
                        ));
                      } else if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'The account already exists for that email.'),
                          duration: Duration(milliseconds: 300),
                        ));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$e"),
                        duration: Duration(milliseconds: 300),
                      ));
                    }
                    // Implement your registration logic here
                    // You can use the emailController.text and passwordController.text to get the entered values
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Set the background color to white
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity,
                        48), // Set the minimum size (width and height) of the button
                    padding: EdgeInsets.symmetric(
                        vertical: 16.0), // Set the vertical padding
                    textStyle:
                        TextStyle(fontSize: 18), // Set the text font size
                  ),
                  child: Text('Register'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white, // Set the text color to white
                  ),
                  child: Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
