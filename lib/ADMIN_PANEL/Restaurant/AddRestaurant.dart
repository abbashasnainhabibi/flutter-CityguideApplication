import 'package:cityguide/ADMIN_PANEL/Restaurant/Restaurantdatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cityguide/ADMIN_PANEL/Appbar.dart';

class AddRestaurant extends StatefulWidget {
  const AddRestaurant({super.key});

  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  final TextEditingController restaurantNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  List<String> base64Images = [];
  List<String> cities = [];
  String? selectedCity;

  final RestaurantDatabase restaurantDatabase = RestaurantDatabase();
  bool _isLoadingCities = true;

  @override
  void initState() {
    super.initState();
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('cities').get();
      setState(() {
        cities = snapshot.docs.map((doc) => doc['cityName'] as String).toList();
        _isLoadingCities = false;
      });
    } catch (e) {
      print('Error fetching cities: $e');
      setState(() {
        _isLoadingCities = false;
      });
    }
  }

  Future<void> _pickAndEncodeImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        base64Images.add(base64Image);
      });
    }
  }

  Future<void> _addRestaurantToFirestore() async {
    String restaurantName = restaurantNameController.text.trim();
    String description = descriptionController.text.trim();
    String latitude = latitudeController.text.trim();
    String longitude = longitudeController.text.trim();

    if (restaurantName.isEmpty ||
        description.isEmpty ||
        latitude.isEmpty ||
        longitude.isEmpty ||
        selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all required fields!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    double? lat = double.tryParse(latitude);
    double? long = double.tryParse(longitude);

    if (lat == null || long == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid latitude or longitude! Please enter valid coordinates.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ));
      return;
    }

    try {
      await restaurantDatabase.addRestaurantWithImages(
        RestaurantName: restaurantName,
        description: description,
        latitude: lat,
        longitude: long,
        Beachlocation: selectedCity!,
        base64Images: base64Images,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Restaurant added successfully!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));

      _clearInputs();
    } catch (e) {
      print("Error adding restaurant to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding restaurant. Please try again later.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void _clearInputs() {
    restaurantNameController.clear();
    descriptionController.clear();
    latitudeController.clear();
    longitudeController.clear();
    setState(() {
      base64Images.clear();
      selectedCity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Text(
                  'Add New Restaurant',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('Restaurant Name', restaurantNameController),
                SizedBox(height: 16),
                _buildTextField('Description', descriptionController, maxLines: 4),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select City',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    _isLoadingCities
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Colors.blueAccent,
                            ),
                          )
                        : DropdownButtonFormField<String>(
                            value: selectedCity,
                            hint: Text(
                              'Select a city',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCity = newValue;
                              });
                            },
                            items: cities.map((String city) {
                              return DropdownMenuItem<String>(
                                value: city,
                                child: Text(
                                  city,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Colors.black87),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'City',
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 16),
                _buildTextField('Latitude', latitudeController),
                SizedBox(height: 16),
                _buildTextField('Longitude', longitudeController),
                SizedBox(height: 20),
                Text(
                  'Add Images',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 15.0,
                  runSpacing: 15.0,
                  children: base64Images.map((base64Image) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.memory(
                            base64Decode(base64Image),
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                base64Images.remove(base64Image);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: _pickAndEncodeImage,
                    icon: Icon(Icons.add_a_photo, color: Colors.white),
                    label:
                        Text('Add Image', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    onPressed: _addRestaurantToFirestore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      elevation: 3,
                      shadowColor: Colors.greenAccent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restaurant, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Add Restaurant',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
    );
  }
}
