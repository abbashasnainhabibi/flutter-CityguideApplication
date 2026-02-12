// ignore_for_file: unused_import

import 'dart:convert';
import 'package:cityguide/ADMIN_PANEL/Appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShowProvinces extends StatelessWidget {
  const ShowProvinces({super.key});

  // Function to show the edit dialog
  Future<void> _showEditDialog(
      BuildContext context, DocumentSnapshot Province) async {
    // TextEditingControllers for province properties
    final ProvinceNameController = TextEditingController(text: Province['ProvinceName']);
    final descriptionController =
        TextEditingController(text: Province['description']);
    final latitudeController =
        TextEditingController(text: Province['latitude'].toString());
    final longitudeController =
        TextEditingController(text: Province['longitude'].toString());
  

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Province', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(ProvinceNameController, 'Province Name'),
                SizedBox(height: 10),
                _buildTextField(descriptionController, 'Description', maxLines: 3),
                SizedBox(height: 10),
               
                _buildTextField(latitudeController, 'Latitude', keyboardType: TextInputType.numberWithOptions(decimal: true)),
                SizedBox(height: 10),
                _buildTextField(longitudeController, 'Longitude', keyboardType: TextInputType.numberWithOptions(decimal: true)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedProvinceName = ProvinceNameController.text;
                final updatedDescription = descriptionController.text;
              

                final updatedLatitude = double.tryParse(latitudeController.text) ?? 0.0;
                final updatedLongitude = double.tryParse(longitudeController.text) ?? 0.0;

                await FirebaseFirestore.instance
                    .collection('Province')
                    .doc(Province.id)
                    .update({
                  'ProvinceName': updatedProvinceName,
                  'description': updatedDescription,
                  
                  'latitude': updatedLatitude,
                  'longitude': updatedLongitude,
                }).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Province updated successfully!"),
        behavior: SnackBarBehavior.floating,
                    
                    backgroundColor: Colors.green,
                  ));
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Failed to update Province!"),
        behavior: SnackBarBehavior.floating,

                    backgroundColor: Colors.red,
                  ));
                });

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to build the text fields
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  // Method to build each city card
  Widget buildProvinceCard(BuildContext context, DocumentSnapshot province) {
    return Card(
      color: const Color.fromARGB(255, 240, 239, 239),
      elevation: 15,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            SizedBox(width: 2.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    province['ProvinceName'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 2, 73, 207),
                    ),
                  ),
                  Text(
                    "Latitude: ${province['latitude'].toStringAsFixed(4)}",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Longitude: ${province['longitude'].toStringAsFixed(4)}",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showEditDialog(context, province);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.green, fontSize: 14.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Province')
                              .doc(province.id)
                              .delete();
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 222, 4, 2),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "All Province's",
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Province').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Province's added yet.",
                style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
              ),
            );
          }

          var province = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: province.length,
            itemBuilder: (context, index) {
              var Province = province[index];
              return buildProvinceCard(context, Province);
            },
          );
        },
      ),
    );
  }
}
