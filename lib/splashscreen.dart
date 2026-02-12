import 'dart:async';
import 'package:cityguide/onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
// Adjust the import to match the path to your Onboarding screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoFadeController;

  @override
  void initState() {
    super.initState();

    // Initialize the fade-in controller for the logo with a duration of 1 second
    _logoFadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Set timer to start logo fade-in halfway through the animation (after 3 seconds)
    Timer(Duration(seconds: 3), () {
      _logoFadeController.forward();
    });

    // Set timer to navigate to Onboarding screen after animation completes (after 6 seconds)
    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Onboarding()),
      );
    });
  }

  @override
  void dispose() {
    _logoFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main animation with padding
            Padding(
              padding: const EdgeInsets.all(20.0), // Adjust padding as needed
              child: Lottie.asset(
                'assets/images/Animation.json',
                width: 500, // Adjust width
                height: 500, // Adjust height
                fit: BoxFit.contain,
              ),
            ),
            // Logo fades in after halfway through the animation
            FadeTransition(
              opacity: _logoFadeController,
              child: Image.asset(
                'assets/images/logo.png',
                width: 200, // Adjust size to match animation space
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
