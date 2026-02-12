import 'package:cloud_firestore/cloud_firestore.dart';

class CityDatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addCityToFirestore({
    required String cityName,
    required String description,
    required double latitude,
    required double longitude,
    required String citylocation,
    required List<String> images,
  }) async {
    try {
      await firestore.collection('cities').add({
        'cityName': cityName,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'location': citylocation,
        'images': images,
      });
    } catch (e) {
      print("Error adding city to Firestore: $e");
    }
  }

  Future<void> addCityWithImages({
    required String cityName,
    required String description,
    required double latitude,
    required double longitude,
    required String citylocation,
    required List<String> base64Images,
  }) async {
    try {
      await addCityToFirestore(
        cityName: cityName,
        description: description,
        latitude: latitude,
        longitude: longitude,
        citylocation: citylocation,
        images: base64Images,
      );
    } catch (e) {
      print("Error adding city with images: $e");
      rethrow;
    }
  }
}
