import 'package:cloud_firestore/cloud_firestore.dart';

class HotelDatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addHotelToFirestore({
    required String HotelName,
    required String description,
    required double latitude,
    required double longitude,
    required String Beachlocation,
    required List<String> images,
  }) async {
    try {
      await firestore.collection('Hotel').add({
        'HotelName': HotelName,
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

  Future<void> addHotelWithImages({
    required String HotelName,
    required String description,
    required double latitude,
    required double longitude,
    required String Beachlocation,
    required List<String> base64Images,
  }) async {
    try {
      await addHotelToFirestore(
        HotelName: HotelName,
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
