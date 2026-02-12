

// ignore_for_file: unused_import

import 'package:cityguide/Beaches/AllBeaches.dart';

import 'package:cityguide/Cities/Allcities.dart';
import 'package:cityguide/Cities/ParticularCity.dart';
import 'package:cityguide/Hotel/AllHotel.dart';
import 'package:cityguide/Mountains/AllMountain.dart';
import 'package:cityguide/Restaurant/AllRestaurant.dart';
import 'package:flutter/material.dart';

class Mycategories extends StatelessWidget {
  const Mycategories({super.key});

 
 

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate the width for each category item (divide screen width by 5 with padding)
    double itemWidth = (screenWidth - 68) / 5; // Adjust spacing here (70 = total spacing)

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            // Category 1
          GestureDetector(
            onTap: () {
               Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Allcities()));
            },
            child: Container(
              height: 60,
              width: itemWidth, // Dynamically calculated width
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_city, color: Colors.blue),
                  Text("Cities",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ],
              ),
            ),
          ),
          // Category 2
          GestureDetector(
            onTap: () {
               Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllMountains()));
            },
            child: Container(
              height: 60,
              width: itemWidth, // Dynamically calculated width
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.landscape, color: Colors.brown),
                  Text("Mountain",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ],
              ),
            ),
          ),
          // Category 3
          GestureDetector(
            onTap: () {
               Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllBeaches()));
            },
            child: Container(
              height: 60,
              width: itemWidth, // Dynamically calculated width
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.beach_access,
                      color: Colors.blueAccent),
                  Text("Beach",
                      style: TextStyle(color: Colors.black, fontSize: 11)),
                ],
              ),
            ),
          ),
          // Category 4
          GestureDetector(
            onTap: () {
               Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllHotel()));
            },
            child: Container(
              height: 60,
              width: itemWidth, // Dynamically calculated width
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hotel,
                      color: Colors.brown),
                  Text("Hotel",
                      style: TextStyle(color: Colors.black, fontSize: 11)),
                ],
              ),
            ),
          ),
            GestureDetector(
            onTap: () {
  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllRestaurant()));
            },
            child: Container(
              height: 60,
              width: itemWidth, // Dynamically calculated width
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, color: Colors.brown),
                  Text("Restaurant",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ],
              ),
            ),
          ),
     
         
        ],
      ),
    );
  }
}
