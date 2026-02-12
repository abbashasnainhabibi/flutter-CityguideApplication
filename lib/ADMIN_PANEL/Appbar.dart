// ignore_for_file: unused_import

import 'dart:developer';

import 'package:cityguide/ADMIN_PANEL/Beach/AddBeach.dart';
import 'package:cityguide/ADMIN_PANEL/Beach/ShowBeach.dart';
import 'package:cityguide/ADMIN_PANEL/Hotel/AddHotel.dart';
import 'package:cityguide/ADMIN_PANEL/Hotel/ShowHotels.dart';
import 'package:cityguide/ADMIN_PANEL/Mountain/Addmountain.dart';
import 'package:cityguide/ADMIN_PANEL/Mountain/ShowMountain.dart';
import 'package:cityguide/ADMIN_PANEL/Province/Addprovince.dart';
import 'package:cityguide/ADMIN_PANEL/Province/ShowProvince.dart';
import 'package:cityguide/ADMIN_PANEL/Restaurant/AddRestaurant.dart';
import 'package:cityguide/ADMIN_PANEL/Restaurant/ShowRestaurants.dart';
import 'package:cityguide/ADMIN_PANEL/Reviews/ShowReviews.dart';
import 'package:cityguide/Credentials/login.dart';
import 'package:cityguide/Reviews/AllReviews.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cityguide/ADMIN_PANEL/City/ShowCities.dart';
import 'package:cityguide/ADMIN_PANEL/Home.dart';
import 'package:cityguide/home.dart';
import 'package:cityguide/ADMIN_PANEL/City/Addcity.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Admin Panel'),
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final int _expandedTileIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 40, 44, 51),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 80),
          children: [
            _buildDrawerItem(
              icon: LineAwesomeIcons.home_solid,
              text: 'Dashboard',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomeScreen()),
                );
              },
            ),
            _buildExpansionTile(
              index: 0,
              icon: Icons.location_on,
              title: 'Province / Location ',
              context: context,
              children: [
                _buildListTile('Add Province', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddProvince()),
                  );
                }),
                _buildListTile("View All Province's", onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShowProvinces()),
                  );
                }),
              ],
            ),
            _buildExpansionTile(
              index: 0,
              icon: LineAwesomeIcons.city_solid,
              title: 'City',
              context: context,
              children: [
                _buildListTile('Add City', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddCity()),
                  );
                }),
                _buildListTile('View All Cities', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShowCities()),
                  );
                }),
              ],
            ),
            _buildExpansionTile(
              index: 1,
              icon: Icons.landscape,
              title: 'Mountain',
              context: context,
              children: [
                _buildListTile('Add Mountain', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddMountain()),
                  );
                }),
                _buildListTile('View All Mountains', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShowMountains()),
                  );
                }),
              ],
            ),
            _buildExpansionTile(
              index: 2,
              icon: Icons.beach_access,
              title: 'Beach',
              context: context,
              children: [
                _buildListTile('Add Beach', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddBeach()),
                  );
                }),
                _buildListTile('View All Beaches', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShowBeaches()),
                  );
                }),
              ],
            ),
            _buildExpansionTile(
              index: 2,
              icon: Icons.hotel,
              title: 'Hotel',
              context: context,
              children: [
                _buildListTile('Add Hotel', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddHotel()),
                  );
                }),
                _buildListTile("View All Hotels", onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShowHotels()),
                  );
                }),
              ],
            ),
            _buildExpansionTile(
              index: 2,
              icon: Icons.restaurant,
              title: 'Restaurant',
              context: context,
              children: [
                _buildListTile('Add Restaurant', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddRestaurant()),
                  );
                }),
                _buildListTile('View All Restaurant', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShowRestaurants()),
                  );
                }),
              ],
            ),
            _buildExpansionTile(
              index: 3,
              icon: Icons.reviews_rounded,
              title: 'Reviews',
              context: context,
              children: [
                _buildListTile('View All Reviews', onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AllReviewsAdmin()), // Redirect to Login screen
                  );
                }),

              ],

            ),
            SizedBox(
              height: 50,
            ),
            _buildDrawerItem(
              icon: LineAwesomeIcons.sign_out_alt_solid,

              text: 'Logout',
              onTap: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile({
    required int index,
    required IconData icon,
    required String title,
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Material(
        color: Colors.transparent, // Avoid background overlay
        child: ExpansionTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          ),
          iconColor: Color.fromARGB(255, 255, 152, 0),
          collapsedIconColor: Colors.white,

          backgroundColor: Colors.transparent,
          children: children, // Transparent background
        ),
      ),
    );
  }

  Widget _buildListTile(String title, {required VoidCallback onTap}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 152, 0),
              fontWeight: FontWeight.w400,
              fontSize: 15 // Medium font weight
              ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
      ),
      tileColor: Colors.transparent, // Ensure no color overlay
      onTap: onTap,
    );
  }
}

// Function to handle logout
void logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => const Mylogin()), // Redirect to Login screen
  );
}
