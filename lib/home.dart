// ignore_for_file: unused_import

import 'package:cityguide/ADMIN_PANEL/City/Addcity.dart';
import 'package:cityguide/ADMIN_PANEL/City/CityDatabase.dart';
import 'package:cityguide/ADMIN_PANEL/Home.dart';
import 'package:cityguide/Bottomnavbar.dart';

import 'package:cityguide/Profile/ProfileScreen.dart';


import 'package:cityguide/cityselected.dart';
import 'package:cityguide/Reviews/Mainreviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'Category.dart';
import 'Recommendation.dart';
import 'Famous_Destinations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {

  User? user;

  @override
  void initState() {
    super.initState();
    // Initialize the user
    user = FirebaseAuth.instance.currentUser;

    // Listen for authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      setState(() {
        user = newUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBar(),
            const SizedBox(height: 20),
            buildBanner(),
            const SizedBox(height: 20),
            Mycategories(), // Custom categories widget
            const SizedBox(height: 20),
            const RecommendedSection(), // Custom recommended section
            const FamousSection(), // Custom famous destinations section
        
          ],
        ),
      ),
    );
  }

  // AppBar Widget
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.person_2_rounded, color: Colors.brown),
        onPressed: () {
          // Navigate to the ProfileScreen without replacement to allow back navigation
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(user: FirebaseAuth.instance.currentUser),
            ),
          );
        },
      ),
      
      title: const Text(
        'Citi Guide ',
        style: TextStyle(
          color: Colors.brown,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_rounded, color: Colors.brown),
          onPressed: () {
          
          },
        ),
         IconButton(
          icon: const Icon(Icons.reviews_rounded, color: Colors.brown),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReviewsPage(user: user, User: null,)),
            );
          },
        ),
       
      ],
    );
  }

  // Search Bar Widget
  Widget buildSearchBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(30),
    ),
    height: 50, // Adjust the height for better vertical alignment
    child: Center( // Center the content inside the container
      child: TextField(
        textAlignVertical: TextAlignVertical.center, // Vertically center the text
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: Colors.black),
          hintText: 'Search for Destination',
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
              // Implement microphone action here
            },
            icon: const Icon(Icons.mic_none_rounded),
          ),
        ),
      ),
    ),
  );
}


  // Banner Widget
  Widget buildBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF608BC1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/images/finallogo.png', // Replace with your asset path
                fit: BoxFit.cover,
                height: 80,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Explore cities!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Enjoy your tour!',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
}
