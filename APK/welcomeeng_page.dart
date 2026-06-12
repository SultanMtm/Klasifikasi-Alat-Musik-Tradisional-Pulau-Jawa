import 'package:flutter/material.dart';

class WelcomeengPage extends StatelessWidget {
  const WelcomeengPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          Text(
            "🎼 Welcome to the Traditional Musical Instrument Classification App",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Text(
            "This app helps you recognize traditional Indonesian musical instruments from images quickly and accurately.\n"
            "\nHow to Use the App:\n"
            "1. Click on the Prediction tab.\n"
            "2. Upload or take a photo.\n"
            "3. The system will display the prediction with its description.\n"
            "4. For full info, see the Information tab.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
