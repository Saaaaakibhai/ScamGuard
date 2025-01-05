import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user/login.dart'; // Import the login.dart file
import 'pages/predict.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure Firebase is initialized
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scam Guard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(), // Ensuring Firebase is initialized
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()), // Show a loading indicator
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')), // Show error if Firebase init fails
            );
          } else {
            return LoginPage(); // Proceed to LoginPage after initialization
          }
        },
      ),
    );
  }
}
