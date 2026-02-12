// ignore_for_file: unused_import

import 'package:cityguide/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cityguide/Reviews/Mainreviews.dart';

class AllReviewsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   AllReviewsPage({super.key});

  Stream<List<Map<String, dynamic>>> _fetchAllReviews() {
    return _firestore.collection('reviews')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'username': doc['username'],
            'email': doc['email'],
            'review': doc['review'],
            'rating': doc['rating'].toDouble(),
          };
        }).toList();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Reviews",style: TextStyle(
          color: Colors.white,fontSize: 16,
        ),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.close,color: Colors.white,)
        ),
        backgroundColor: const Color.fromARGB(255, 2, 73, 207),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _fetchAllReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reviews yet.'));
          }

          final reviews = snapshot.data!;

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _buildReview(
                review['username'],
                review['rating'],
                review['review'],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildReview(String username, double rating, String comment) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF4A6572),
                radius: 20,
                child: Text(
                  username[0],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                username,
                style: GoogleFonts.poppins(
                  color: Color(0xFF344955),
                  fontSize: 16,
                ),
              ),
              Spacer(),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Color(0xFFF9AA33),
                ),
                itemCount: 5,
                itemSize: 18,
                direction: Axis.horizontal,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            comment,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}