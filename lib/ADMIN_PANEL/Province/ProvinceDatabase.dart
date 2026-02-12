// ignore_for_file: unused_import

import 'package:cityguide/ADMIN_PANEL/Province/Addprovince.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProvinceDatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProvinceToFirestore({
    required String ProvinceName,
    required String description,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await firestore.collection('Province').add({
        'ProvinceName': ProvinceName,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (e) {
      print("Error adding Province to Firestore: $e");
    }
  }

  Future<void> AddProvince({
    required String cityName,
    required String description,
    required String latitude,
    required String longitude,
  }) async {
    try {
      double lat = double.tryParse(latitude) ?? 0.0;
      double long = double.tryParse(longitude) ?? 0.0;

      await addProvinceToFirestore(
        ProvinceName: cityName,
        description: description,
        latitude: lat,
        longitude: long,
      );
    } catch (e) {
      print("Error adding province: $e");
    }
  }
}
