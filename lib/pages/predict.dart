import 'package:flutter/material.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";
  bool isScam = false; // Tracks if the result is a scam

  // Function to handle scam detection logic
  void _detectScam() {
    String websiteLink = _controller.text;

    // Replace with actual model or API call
    setState(() {
      if (websiteLink.contains("scam")) {
        _result = "This website is a Scam!";
        isScam = true;
      } else {
        _result = "This website is Safe!";
        isScam = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scam Guard"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/image/scamguardbackground.png'), // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white), // Text color set to white
                  decoration: InputDecoration(
                    labelText: "Enter Website Link",
                    labelStyle: const TextStyle(color: Colors.redAccent), // Label text color
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.redAccent), // Border color
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.redAccent, width: 2.0), // Focused border color
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _detectScam,
                  child: const Text("Detect"),
                ),
                const SizedBox(height: 16),
                Text(
                  _result,
                  style: TextStyle(
                    color: isScam ? Colors.red : Colors.green, // Dynamic text color
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}