import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'register.dart'; // Import the register page for navigation
import 'package:scamguard/pages/predict.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Check if the entered credentials match the provided ones
                    if (emailController.text == 'mahedi@gmail.com' && passwordController.text == '123456') {
                      // If credentials match, navigate to predict.dart
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => PredictPage()), // Navigate to predict.dart
                      );
                    } else {
                      try {
                        // Firebase Authentication
                        UserCredential userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        // Check if user data exists in Firestore
                        DocumentSnapshot userDoc = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userCredential.user?.uid)
                            .get();

                        if (userDoc.exists) {
                          // Navigate to predict page on successful login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => PredictPage()), // Navigate to predict.dart
                          );
                        } else {
                          print('User data not found in Firestore');
                        }
                      } on FirebaseAuthException catch (e) {
                        String message = '';
                        if (e.code == 'user-not-found') {
                          message = 'No user found for that email.';
                        } else if (e.code == 'wrong-password') {
                          message = 'Wrong password provided for that user.';
                        } else {
                          message = 'Error: ${e.message}';
                        }
                        print(message);
                      }
                    }
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Don\'t have an account? Register here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
