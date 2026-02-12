// ignore_for_file: unused_import

import 'dart:convert';
import 'package:cityguide/Beaches/ParticularBeach.dart';
import 'package:cityguide/cities/ParticularCity.dart';
import 'package:cityguide/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllBeaches extends StatefulWidget {
  const AllBeaches({super.key});

  @override
  _AllBeachesState createState() => _AllBeachesState();
}

class _AllBeachesState extends State<AllBeaches> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainHomeScreen(),
              ),
            );
          },
          icon: Icon(Icons.close_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBar(),
            SizedBox(height: 20),
            buildCityGrid(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      height: 50,
      child: Center(
        child: TextField(
          controller: _searchController,
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim().toLowerCase(); // Update the search query
            });
          },
          decoration: InputDecoration(
            icon: const Icon(Icons.search, color: Colors.black),
            hintText: 'Search Beaches',
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = ''; // Clear the search query
                });
              },
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCityGrid() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Beach').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No cities available.'));
        }

        var cities = snapshot.data!.docs;

        // Filter cities based on the search query
        if (_searchQuery.isNotEmpty) {
          cities = cities.where((city) {
            var cityName = city['BeachName']?.toString().toLowerCase() ?? '';
            return cityName.contains(_searchQuery);
          }).toList();
        }

        return cities.isEmpty
            ? const Center(child: Text('No matching Beach found.'))
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4.2 / 5,
                ),
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  var city = cities[index];
                  var imageField = city['images'];
                  String base64Image = '';

                  if (imageField is List && imageField.isNotEmpty) {
                    base64Image = imageField[0];
                  } else if (imageField is String) {
                    base64Image = imageField;
                  }

                  String name = city['BeachName'] ?? 'Unknown Beach';
                  String location = city['location'] ?? 'Unknown Location';
                  String description = city['description'] ?? 'Unknown description';
                  double latitude = city['latitude']?.toDouble() ?? 0.0;
                  double longitude = city['longitude']?.toDouble() ?? 0.0;

                  return buildCityCard(context, base64Image, name, location, description, latitude, longitude);
                },
              );
      },
    );
  }

 Widget buildCityCard(BuildContext context, String base64Image, String name, String location, String description, double latitude, double longitude) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BeachDetailPage(
            image: base64Image,
            name: name,
            location: location,
            description: description,
            latitude: latitude,
            longitude: longitude,
          ),
        ),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: base64Image.isNotEmpty
                  ? Image.memory(
                      base64Decode(base64Image),
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/logo4.png',
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 10),
            Center(
              child: buildHighlightedText(name, _searchQuery), // Use the helper function here
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 20.0,
                  color: const Color.fromARGB(255, 222, 4, 2),
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 51, 102, 196),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper function to highlight matching text
Widget buildHighlightedText(String text, String query) {
  // Check if the query matches any part of the text
  final matches = query.isNotEmpty && text.toLowerCase().contains(query.toLowerCase());

  return Text(
    text,
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: matches ? const Color.fromARGB(255, 8, 193, 61) : Colors.black, // Highlight the entire name if there's a match
    ),
  );
}


    
  }
