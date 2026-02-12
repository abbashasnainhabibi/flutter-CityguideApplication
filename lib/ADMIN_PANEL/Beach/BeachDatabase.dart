import 'package:cloud_firestore/cloud_firestore.dart';

class BeachDatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMountainToFirestore({
    required String BeachName,
    required String description,
    required double latitude,
    required double longitude,
    required String Beachlocation,
    required List<String> images,
  }) async {
    try {
      await firestore.collection('Beach').add({
        'BeachName': BeachName,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'location': Beachlocation,
        'images': images,
      });
    } catch (e) {
      print("Error adding Beach to Firestore: $e");
    }
  }

  Future<void> addMountainWithImages({
    required String BeachName,
    required String description,
    required double latitude,
    required double longitude,
    required String Beachlocation,
    required List<String> base64Images,
  }) async {
    try {
      await addMountainToFirestore(
        BeachName: BeachName,
        description: description,
        latitude: latitude,
        longitude: longitude,
        Beachlocation: Beachlocation,
        images: base64Images,
      );
    } catch (e) {
      print("Error adding Beach with images: $e");
      rethrow;
    }
  }
}
