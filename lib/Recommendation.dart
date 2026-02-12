import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommendation',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'View All',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cities')
                .limit(3) // Limit to the latest 3 cities
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No recommendations available.'));
              }

              var cities = snapshot.data!.docs;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  var city = cities[index];
                  String base64Image = city['images'].isNotEmpty
                      ? city['images'][0] // Assuming first image is base64
                      : ''; // Empty string if no image

                  return RecommendedPlace(
                    image: base64Image,
                    title: city['cityName'],
                    location: city['location'],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecommendedPlace extends StatelessWidget {
  final String image;  // Base64 string
  final String title;
  final String location;

  const RecommendedPlace({super.key, 
    required this.image,
    required this.title,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image.isEmpty
                ? Image.asset(
                    'assets/images/logo4.png', // Default image if base64 is empty
                    height: 120,
                    width: 160,
                    fit: BoxFit.cover,
                  )
                : Image.memory(
                    base64Decode(image), // Decode the base64 string
                    height: 120,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, color: Color.fromARGB(255,222, 4, 2), size: 16),
              const SizedBox(width: 4),
              // Prevent overflow by wrapping the location text
              Flexible(
                child: Text(
                  location,
                  style: const TextStyle(color:Color.fromARGB(255, 51, 102, 196),),
                  overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                  maxLines: 1, // Prevents multiple lines
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

