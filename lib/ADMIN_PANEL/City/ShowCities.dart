import 'dart:convert';
import 'package:cityguide/ADMIN_PANEL/Appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShowCities extends StatelessWidget {
  const ShowCities({super.key});

  // Function to show the edit dialog
  Future<void> _showEditDialog(
      BuildContext context, DocumentSnapshot city) async {
    // TextEditingControllers for city properties
    final cityNameController = TextEditingController(text: city['cityName']);
    final descriptionController =
        TextEditingController(text: city['description']);
    final latitudeController =
        TextEditingController(text: city['latitude'].toString());
    final longitudeController =
        TextEditingController(text: city['longitude'].toString());
    final cityLocationController =
        TextEditingController(text: city['location'].toString());

    showDialog(
      context: context,
      builder: (context) {
       return AlertDialog(
        backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  title: Text(
    'Edit City',
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
        _buildTextField(cityNameController, 'City Name'),
                SizedBox(height: 10),
                _buildTextField(descriptionController, 'Description', maxLines: 5),
                SizedBox(height: 10),
                _buildTextField(cityLocationController, 'City Location'),
                SizedBox(height: 10),
                _buildTextField(latitudeController, 'Latitude', keyboardType: TextInputType.numberWithOptions(decimal: true)),
                SizedBox(height: 10),
                _buildTextField(longitudeController, 'Longitude', keyboardType: TextInputType.numberWithOptions(decimal: true)),
      ],
    ),
  ),
  actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  actions: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Cancel Button
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        // Save Button
        ElevatedButton(
          onPressed: () async {
            final updatedCityName = cityNameController.text.trim();
            final updatedDescription = descriptionController.text.trim();
            final updatedCityLocation = cityLocationController.text.trim();

            final updatedLatitude = double.tryParse(latitudeController.text.trim()) ?? 0.0;
            final updatedLongitude = double.tryParse(longitudeController.text.trim()) ?? 0.0;

            await FirebaseFirestore.instance
                .collection('cities')
                .doc(city.id)
                .update({
              'cityName': updatedCityName,
              'description': updatedDescription,
              'location': updatedCityLocation,
              'latitude': updatedLatitude,
              'longitude': updatedLongitude,
            }).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("City updated successfully!"),
        behavior: SnackBarBehavior.floating,

                  backgroundColor: Colors.green,
                ),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to update city!"),
        behavior: SnackBarBehavior.floating,

                  backgroundColor: Colors.red,
                ),
              );
            });

            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Save',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
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
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  // Method to build each city card
  Widget buildCityCard(BuildContext context, DocumentSnapshot city) {
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
            // Display image if available
            if (city['images'] != null && city['images'].isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.memory(
                  base64Decode(city['images'][0]),
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
                    city['cityName'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 2, 73, 207),
                    ),
                  ),
                  Text(
                    "Latitude: ${city['latitude'].toStringAsFixed(4)}",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Longitude: ${city['longitude'].toStringAsFixed(4)}",
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
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
                          city['location'],
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
                          _showEditDialog(context, city);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.green, fontSize: 14.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('cities')
                              .doc(city.id)
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
          'All Cities',
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
        stream: FirebaseFirestore.instance.collection('cities').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No cities added yet.',
                style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
              ),
            );
          }

          var cities = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: cities.length,
            itemBuilder: (context, index) {
              var city = cities[index];
              return buildCityCard(context, city);
            },
          );
        },
      ),
    );
  }
}
