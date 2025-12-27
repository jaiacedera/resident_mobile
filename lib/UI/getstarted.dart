import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login.dart'; // <--- THIS LINK REMOVES THE RED ERROR

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase not connected yet: $e");
  }
  runApp(const BusoBusoApp());
}

class BusoBusoApp extends StatelessWidget {
  const BusoBusoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Lato'),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double cssHeight = 852;

    return Scaffold(
      body: Stack(
        children: [
          // 1. BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/getstarted_background.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.blueGrey),
            ),
          ),

          // 2. CIRCULAR LOGO
          Positioned(
            left: 0,
            right: 0,
            top: 262,
            child: Center(
              child: Container(
                width: 136,
                height: 136,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/busobuso_logo.png'),
                ),
              ),
            ),
          ),

          // 3. TITLES
          Positioned(
            top: cssHeight * 0.4883,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  "BARANGAY BUSO-BUSO\nRESIDENT EOC APP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    height: 1.2,
                    letterSpacing: 2.4,
                    color: Color(0xFFF2EFEF),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Your guide to safety and preparedness",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFF2EFEF),
                  ),
                ),
              ],
            ),
          ),

          // 4. GET STARTED BUTTON
          Positioned(
            bottom: 100,
            left: 54,
            right: 54,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                // This command triggers the transition to login.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF274C77),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33),
                ),
              ),
              child: const Text(
                "GET STARTED", 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
              ),
            ),
          ),

          // 5. FOOTER
          Positioned(
            bottom: cssHeight * 0.0493,
            left: 0,
            right: 0,
            child: const Text(
              "Stay informed. Stay safe. © 2025 All rights reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFFF2EFEF)),
            ),
          ),
        ],
      ),
    );
  }
}