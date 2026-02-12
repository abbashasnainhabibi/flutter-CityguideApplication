// reviews_page.dart
// ignore_for_file: duplicate_import

import 'package:cityguide/Reviews/AllReviews.dart';
import 'package:cityguide/Reviews/ReviewDatabase.dart';
import 'package:cityguide/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cityguide/Reviews/ReviewDatabase.dart';


class ReviewsPage extends StatefulWidget {
  final User? user;

  const ReviewsPage({super.key, required this.user, required User});

  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  double _rating = 1; // Default rating
  final TextEditingController _reviewController = TextEditingController();
  final ReviewDatabase _reviewDatabase = ReviewDatabase(); // Instantiate ReviewDatabase

  Future<void> _submitReview() async {
    final String username = widget.user?.displayName ?? 'Anonymous';
    final String email = widget.user?.email ?? 'No email available';
    final String review = _reviewController.text.trim();

    try {
      await _reviewDatabase.submitReview(
        username: username,
        email: email,
        review: review,
        rating: _rating,
      );

      _reviewController.clear();
      setState(() {
        _rating = 1; // Reset rating after submission
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Review submitted!',),
         backgroundColor: Color.fromRGBO(146, 208, 80, 1),
         duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error submitting review: $e'),
           backgroundColor: Color.fromARGB(255,222, 4, 2),
           duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "Review Page",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 73, 207),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainHomeScreen()),
            );
          },
          icon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.close, color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Color(0xFFF2F5F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              _buildReviewInputSection(context),
              SizedBox(height: 20),
              _buildUserReviewsHeader(context),
              SizedBox(height: 10),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: _reviewDatabase.fetchLatestReviews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No reviews yet.');
                  }

                  final reviews = snapshot.data!;

                  return Column(
                    children: reviews.map((review) {
                      return _buildReview(
                        review['username'],
                        review['rating'],
                        review['review'],
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewInputSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leave a Review',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Color(0xFF344955),
            ),
          ),
          SizedBox(height: 12),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 30,
            unratedColor: Colors.grey.shade300,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Color(0xFFF9AA33),
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 20),
          TextField(
            controller: _reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFF6F9FC),
              hintText: 'Share your experience...',
              hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A6572),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(String username, double rating, String comment) {
    return Container(
      margin: EdgeInsets.only(top: 16),
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

  Widget _buildUserReviewsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'User Reviews',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF344955),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllReviewsPage()),
            );
          },
          child: Text(
            'View More',
            style: GoogleFonts.poppins(
              color: Color(0xFF4A6572),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
