import 'dart:convert';
import 'package:cityguide/ADMIN_PANEL/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShowMountains extends StatelessWidget {
  const ShowMountains({super.key});

  // Function to show the edit dialog
  Future<void> _showEditDialog(
      BuildContext context, DocumentSnapshot mountain) async {
    // TextEditingControllers for mountain properties
    final mountainNameController =
        TextEditingController(text: mountain['MountainName']);
    final descriptionController =
        TextEditingController(text: mountain['description']);
    final latitudeController =
        TextEditingController(text: mountain['latitude'].toString());
    final longitudeController =
        TextEditingController(text: mountain['longitude'].toString());
    final locationController =
        TextEditingController(text: mountain['location'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Edit Mountain',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(mountainNameController, 'Mountain Name'),
                SizedBox(height: 10),
                _buildTextField(descriptionController, 'Description',
                    maxLines: 5),
                SizedBox(height: 10),
                _buildTextField(locationController, 'Location'),
                SizedBox(height: 10),
                _buildTextField(latitudeController, 'Latitude',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true)),
                SizedBox(height: 10),
                _buildTextField(longitudeController, 'Longitude',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true)),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                  ),
                  child: Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final updatedMountainName =
                        mountainNameController.text.trim();
                    final updatedDescription =
                        descriptionController.text.trim();
                    final updatedLocation = locationController.text.trim();
                    final updatedLatitude = double.tryParse(
                            latitudeController.text.trim()) ??
                        0.0;
                    final updatedLongitude = double.tryParse(
                            longitudeController.text.trim()) ??
                        0.0;

                    await FirebaseFirestore.instance
                        .collection('Mountains')
                        .doc(mountain.id)
                        .update({
                      'MountainName': updatedMountainName,
                      'description': updatedDescription,
                      'location': updatedLocation,
                      'latitude': updatedLatitude,
                      'longitude': updatedLongitude,
                    }).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Mountain updated successfully!"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Failed to update mountain!"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Save', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  Widget buildMountainCard(BuildContext context, DocumentSnapshot mountain) {
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
            if (mountain['images'] != null && mountain['images'].isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.memory(
                  base64Decode(mountain['images'][0]),
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mountain['MountainName'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 2, 73, 207),
                    ),
                  ),
                  Text(
                    "Latitude: ${mountain['latitude'].toStringAsFixed(4)}",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                  Text(
                    "Longitude: ${mountain['longitude'].toStringAsFixed(4)}",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        LineAwesomeIcons.map_marker_alt_solid,
                        size: 26.0,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          mountain['location'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: const Color.fromARGB(255, 51, 102, 196),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showEditDialog(context, mountain);
                        },
                        child: Text("Edit",
                            style:
                                TextStyle(color: Colors.green, fontSize: 14.0)),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Mountains')
                              .doc(mountain.id)
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
          'All Mountains',
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
        stream: FirebaseFirestore.instance.collection('Mountains').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No mountains added yet.',
                style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
              ),
            );
          }

          var mountains = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: mountains.length,
            itemBuilder: (context, index) {
              var mountain = mountains[index];
              return buildMountainCard(context, mountain);
            },
          );
        },
      ),
    );
  }
}
