import 'package:cityguide/ADMIN_PANEL/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cityguide/ADMIN_PANEL/City/CityDatabase.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  _AddCityState createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController citylocationController = TextEditingController();

  List<String> base64Images = []; // Store Base64-encoded images
  List<String> provinces = []; // Store province names
  String? selectedProvince;  // Selected province from the dropdown

  final CityDatabase cityDatabase = CityDatabase();
  bool _isLoadingProvinces = true;  // Flag to check if provinces are loading

  @override
  void initState() {
    super.initState();
    _fetchProvinces();  // Fetch provinces when the widget is first created
  }

  // Fetch provinces from Firestore
  Future<void> _fetchProvinces() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Province').get();
      setState(() {
        provinces = snapshot.docs.map((doc) => doc['ProvinceName'] as String).toList();
        _isLoadingProvinces = false; // Provinces are loaded, stop loading indicator
      });
    } catch (e) {
      print('Error fetching provinces: $e');
      setState(() {
        _isLoadingProvinces = false;  // Stop loading even if there was an error
      });
    }
  }

  // Pick and encode image to Base64
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

  // Add City to Firestore
  Future<void> _addCityToFirestore() async {
    String cityName = cityNameController.text.trim();
    String description = descriptionController.text.trim();
    String latitude = latitudeController.text.trim();
    String longitude = longitudeController.text.trim();
    String location = citylocationController.text.trim();

    // Validate inputs
    if (cityName.isEmpty || description.isEmpty || latitude.isEmpty || longitude.isEmpty  || selectedProvince == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields!'),
        behavior: SnackBarBehavior.floating,

        backgroundColor:  Color.fromARGB(255,222, 4, 2),
      ));
      return;
    }

    try {
      // Convert latitude and longitude to double
      double lat = double.tryParse(latitude) ?? 0.0;
      double long = double.tryParse(longitude) ?? 0.0;

      await cityDatabase.addCityWithImages(
        cityName: cityName,
        description: description,
        latitude: lat,
        longitude: long,
        citylocation: selectedProvince!,
        base64Images: base64Images,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('City Added Successfully!'),
        behavior: SnackBarBehavior.floating,

        backgroundColor:Color.fromRGBO(146, 208, 80, 1),
      ));

      // Clear inputs after successful city addition
      cityNameController.clear();
      descriptionController.clear();
      latitudeController.clear();
      longitudeController.clear();
      citylocationController.clear();
      setState(() {
        base64Images.clear();
        selectedProvince = null;
      });
    } catch (e) {
      print("Error adding city to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding city to Firestore'),
        behavior: SnackBarBehavior.floating,

        backgroundColor:  Color.fromARGB(255,222, 4, 2),
      ));
    }
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
                  'Add New City',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('City Name', cityNameController),
                SizedBox(height: 16),
                _buildTextField('Description', descriptionController, maxLines: 4),
                SizedBox(height: 16),
                // Show CircularProgressIndicator if provinces are still loading
              // Inside your widget's build method
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Select Province',
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    SizedBox(height: 8),
    _isLoadingProvinces
        ? Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.blueAccent,
              ),
            ),
          )
        : DropdownButtonFormField<String>(
            value: selectedProvince,
            hint: Text(
              'Select a province',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[500]),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedProvince = newValue;
              });
            },
            items: provinces.map((String province) {
              return DropdownMenuItem<String>(
                value: province,
                child: Text(
                  province,
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'City Location',
              labelStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.0),
                borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            ),
            dropdownColor: Colors.white,
            elevation: 4,
            iconEnabledColor: Colors.blue,
            iconSize: 24.0,
          ),
  
   
  ],
),


                SizedBox(height: 16),
                _buildTextField('Latitude', latitudeController),
                SizedBox(height: 16),
                _buildTextField('Longitude', longitudeController),
                SizedBox(height: 20),
                // Add Images Section
                Text(
                  'Add Images',
                  style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
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
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.grey[300]!, width: 1.0),
                            ),
                            child: Image.memory(
                              base64Decode(base64Image),
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
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
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
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
                    label: Text('Add Image', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                // Submit Button to Add City
                Center(
                  child: ElevatedButton(
                    onPressed: _addCityToFirestore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      elevation: 3,
                      shadowColor: Colors.greenAccent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_location_alt_outlined, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Add City',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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

  // Helper method to build text fields
  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      ),
    );
  }
}
