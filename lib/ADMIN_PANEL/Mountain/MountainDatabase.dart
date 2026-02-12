import 'package:cloud_firestore/cloud_firestore.dart';

class MountainDatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMountainToFirestore({
    required String MountainName,
    required String description,
    required double latitude,
    required double longitude,
    required String Mountainlocation,
    required List<String> images,
  }) async {
    try {
      await firestore.collection('Mountains').add({
        'MountainName': MountainName,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'location': Mountainlocation,
        'images': images,
      });
    } catch (e) {
      print("Error adding Mountain to Firestore: $e");
    }
  }

  Future<void> addMountainWithImages({
    required String MountainName,
    required String description,
    required double latitude,
    required double longitude,
    required String Mountainlocation,
    required List<String> base64Images,
  }) async {
    try {
      await addMountainToFirestore(
        MountainName: MountainName,
        description: description,
        latitude: latitude,
        longitude: longitude,
        Mountainlocation: Mountainlocation,
        images: base64Images,
      );
    } catch (e) {
      print("Error adding Mountain with images: $e");
      rethrow;
    }
  }
}
