import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantDatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addRestaurantToFirestore({
    required String RestaurantName,
    required String description,
    required double latitude,
    required double longitude,
    required String Beachlocation,
    required List<String> images,
  }) async {
    try {
      await firestore.collection('Restaurant').add({
        'RestaurantName': RestaurantName,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'location': Beachlocation,
        'images': images,
      });
    } catch (e) {
      print("Error adding Hotel to Firestore: $e");
    }
  }

  Future<void> addRestaurantWithImages({
    required String RestaurantName,
    required String description,
    required double latitude,
    required double longitude,
    required String Beachlocation,
    required List<String> base64Images,
  }) async {
    try {
      await addRestaurantToFirestore(
        RestaurantName: RestaurantName,
        description: description,
        latitude: latitude,
        longitude: longitude,
        Beachlocation: Beachlocation,
        images: base64Images,
      );
    } catch (e) {
      print("Error adding Hotel with images: $e");
      rethrow;
    }
  }
}
