import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FamousSection extends StatelessWidget {
  const FamousSection({super.key});

  @override
  Widget build(BuildContext context) {
    double itemWidth = 140; // Fixed width for each item
    double itemHeight = 180; // Fixed height for each item

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Famous Places',
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
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Hotel')
              .limit(9) // Limit to 9 items
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No recommendations available.'));
            }

            var places = snapshot.data!.docs;

            return Wrap(
              spacing: 10, // Horizontal space between items
              runSpacing: 10, // Vertical space between rows
              children: List.generate(
                places.length,
                (index) {
                  var place = places[index];
                  String base64Image = place['images'].isNotEmpty
                      ? place['images'][0] // Assuming first image is base64
                      : ''; // Empty string if no image

                  return SizedBox(
                    width: itemWidth, // Static width
                    height: itemHeight, // Static height
                    child: RecommendedPlace(
                      image: base64Image,
                      title: place['HotelName'],
                      location: place['location'],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class RecommendedPlace extends StatelessWidget {
  final String image; // Base64 string
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
      width: 140, // Static width
      height: 180, // Static height
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
                    height: 100, // Fixed image height
                    width: 120, // Fixed image width
                    fit: BoxFit.cover,
                  )
                : Image.memory(
                    base64Decode(image), // Decode the base64 string
                    height: 100, // Fixed image height
                    width: 120, // Fixed image width
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, // Truncate if too long
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on,
                  color: Color.fromARGB(255, 222, 4, 2), size: 14),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 51, 102, 196),
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
