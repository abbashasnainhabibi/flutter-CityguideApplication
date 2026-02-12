// ignore_for_file: unused_import

import 'package:cityguide/ADMIN_PANEL/Home.dart';

import 'package:cityguide/description.dart';
import 'package:cityguide/firebase_options.dart';
import 'package:cityguide/home.dart';
import 'package:cityguide/Credentials/login.dart';
import 'package:cityguide/Reviews/Mainreviews.dart';
import 'package:cityguide/splashscreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(), // Decides the initial screen based on auth state
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Check if the logged-in user's email is "admin@gmail.com"
      if (user.email == "admin@gmail.com") {
        return AdminHomeScreen(); // Redirect to the Admin Panel
      } else {
        return MainHomeScreen(); // Redirect to the User Panel
      }
    } else {
      return Mylogin(); // Redirect to login screen if not logged in
    }
  }
}

