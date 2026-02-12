import 'package:cityguide/ADMIN_PANEL/Appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class AllReviewsAdmin extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   AllReviewsAdmin({super.key});

  // Fetch all reviews from Firestore
  Stream<List<Map<String, dynamic>>> _fetchAllReviews() {
    return _firestore
        .collection('reviews')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id, // Review ID
          'username': doc['username'],
          'email': doc['email'],
          'review': doc['review'],
          'rating': doc['rating'].toDouble(),
        };
      }).toList();
    });
  }

  // Edit review function
  void _editReview(String reviewId, BuildContext context, String currentReview) {
    TextEditingController reviewController =
        TextEditingController(text: currentReview);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Review"),
        content: TextField(
          controller: reviewController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Enter updated review",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              // Save updated review
              await FirebaseFirestore.instance
                  .collection('reviews')
                  .doc(reviewId)
                  .update({'review': reviewController.text});
              Navigator.pop(context); // Close dialog
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  // Delete review function
  void _deleteReview(String reviewId, BuildContext context) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Review"),
        content: Text("Are you sure you want to delete this review?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Do not delete
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Confirm delete
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed) {
      await FirebaseFirestore.instance.collection('reviews').doc(reviewId).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(), // Use CustomAppBar
      drawer: CustomDrawer(), // CustomDrawer for navigation
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
                review['id'], // Pass review ID
                context,
              );
            },
          );
        },
      ),
    );
  }

  // Build each review card with Edit and Delete options
  Widget _buildReview(String username, double rating, String comment,
      String reviewId, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:  const Color.fromARGB(255, 24, 85, 199),
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
                  color:Colors.white,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 228, 192, 138),
                ),
                itemCount: 5,
                itemSize: 18,
                direction: Axis.horizontal,
              ),
            ],
          ),
        
          Text(
            comment,
            style: GoogleFonts.poppins(
              color:Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => _editReview(reviewId, context, comment),
                child: Text(
                  "Edit",
                  style: TextStyle(color:Colors.white,fontSize: 14),
                  
                ),
              ),
              TextButton(
                onPressed: () => _deleteReview(reviewId, context),
                child: Text(
                  "Delete",
                  style: TextStyle(color:  Color.fromARGB(255, 235, 4, 0),fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
