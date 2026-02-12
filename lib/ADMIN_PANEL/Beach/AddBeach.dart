import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cityguide/ADMIN_PANEL/Beach/BeachDatabase.dart';
import 'package:cityguide/ADMIN_PANEL/Appbar.dart';

class AddBeach extends StatefulWidget {
  const AddBeach({super.key});

  @override
  _AddBeachState createState() => _AddBeachState();
}

class _AddBeachState extends State<AddBeach> {
  final TextEditingController beachNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  List<String> base64Images = [];
  List<String> provinces = [];
  String? selectedProvince;

  final BeachDatabase beachDatabase = BeachDatabase();
  bool _isLoadingProvinces = true;

  @override
  void initState() {
    super.initState();
    _fetchProvinces();
  }

  Future<void> _fetchProvinces() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('cities').get();
      setState(() {
        provinces =
            snapshot.docs.map((doc) => doc['cityName'] as String).toList();
        _isLoadingProvinces = false;
      });
    } catch (e) {
      print('Error fetching provinces: $e');
      setState(() {
        _isLoadingProvinces = false;
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

  Future<void> _addBeachToFirestore() async {
    String beachName = beachNameController.text.trim();
    String description = descriptionController.text.trim();
    String latitude = latitudeController.text.trim();
    String longitude = longitudeController.text.trim();

    if (beachName.isEmpty ||
        description.isEmpty ||
        latitude.isEmpty ||
        longitude.isEmpty ||
        selectedProvince == null) {
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
      await beachDatabase.addMountainWithImages(
        BeachName: beachName,
        description: description,
        latitude: lat,
        longitude: long,
        Beachlocation: selectedProvince!,
        base64Images: base64Images,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Beach added successfully!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ));

      _clearInputs();
    } catch (e) {
      print("Error adding beach to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding beach. Please try again later.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void _clearInputs() {
    beachNameController.clear();
    descriptionController.clear();
    latitudeController.clear();
    longitudeController.clear();
    setState(() {
      base64Images.clear();
      selectedProvince = null;
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
                  'Add New Beach',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('Beach Name', beachNameController),
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
                    _isLoadingProvinces
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Colors.blueAccent,
                            ),
                          )
                        : DropdownButtonFormField<String>(
                            value: selectedProvince,
                            hint: Text(
                              'Select a province',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
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
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Colors.black87),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Province',
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
                    onPressed: _addBeachToFirestore,
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
                        Icon(Icons.beach_access, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Add Beach',
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
