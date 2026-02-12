// ignore_for_file: unused_import

import 'package:cityguide/ADMIN_PANEL/Province/ProvinceDatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:cityguide/ADMIN_PANEL/Appbar.dart';


class AddProvince extends StatefulWidget {
  const AddProvince({super.key});

  @override
  _AddProvinceState createState() => _AddProvinceState();
}

class _AddProvinceState extends State<AddProvince> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController provinceNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();


 
  final ProvinceDatabase provinceDatabase = ProvinceDatabase();

  

  Future<void> addProvinceToFirestore() async {
    String provinceName = provinceNameController.text.trim();
    String description = descriptionController.text.trim();
    String latitude = latitudeController.text.trim();
    String longitude = longitudeController.text.trim();
  
    

    if (provinceName.isEmpty || description.isEmpty || latitude.isEmpty || longitude.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255,222, 4, 2),
        content: Text('Please fill all fields!'),
        
        duration: Duration(seconds: 1),
        
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    try {
      await provinceDatabase.AddProvince(
      
        cityName: provinceName,
        description: description,
        latitude: latitude,
        longitude: longitude,
       
       
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('province Added Successfully!'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromRGBO(146, 208, 80, 1),
      ));
      provinceNameController.clear();
      descriptionController.clear();
      latitudeController.clear();
      longitudeController.clear();
    


     
    } catch (e) {
      print("Error adding province to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding Province to Firestore'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,

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
                  'Add New province',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('province Name', provinceNameController),
                
                SizedBox(height: 16),
                _buildTextField('Description', descriptionController, maxLines: 4),
                 SizedBox(height: 20),
               
                _buildTextField('Latitude', latitudeController),
                SizedBox(height: 16),
                _buildTextField('Longitude', longitudeController),
                SizedBox(height: 20),
               
                          

                SizedBox(height: 10),
              
                SizedBox(height: 24.0),
                             Center(
                child: ElevatedButton(
                  onPressed: addProvinceToFirestore,
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
                        'Add Province',
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
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
        ),
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
