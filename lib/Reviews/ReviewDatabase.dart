// review_database.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to submit a review to Firestore
  Future<void> submitReview({
    required String username,
    required String email,
    required String review,
    required double rating,
  }) async {
    if (review.isNotEmpty && rating > 0) {
      await _firestore.collection('reviews').add({
        'username': username,
        'email': email,
        'review': review,
        'rating': rating,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception("Review or rating cannot be empty");
    }
  }

  // Method to fetch the latest reviews from Firestore
  Stream<List<Map<String, dynamic>>> fetchLatestReviews() {
    return _firestore.collection('reviews')
      .orderBy('timestamp', descending: true)
      .limit(5)
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
}
