// ignore_for_file: unused_import

import 'package:cityguide/Profile/UpdateProfile.dart';
import 'package:cityguide/description.dart';
import 'package:cityguide/home.dart';
import 'package:cityguide/Credentials/login.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final User? user;

  const ProfileScreen({super.key, required this.user});

  // Function to handle logout
  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const Mylogin()), // Redirect to Login screen
    );
  }

  @override
  Widget build(BuildContext context) {
    print("User Display Name: ${user?.displayName ?? 'No display name'}");
    print("User Email: ${user?.email ?? 'No email'}");

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MainHomeScreen()));
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Example toggle dark/light mode
              isDark = !isDark;
              // This change needs to be handled by a StatefulWidget or app-wide theme setting
            },
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon,
                color: Colors.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
               child: SizedBox(
                width: 120,
                height: 120,
                child: ClipOval(
                  child: user?.photoURL != null
                      ? Image.network(
                          user!.photoURL!,
                          fit: BoxFit.cover,
                          width: 170,
                          height: 170,
                        )
                      : Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                ),
              ),
            ),

            Text(
              user?.displayName != null && user!.displayName!.isNotEmpty
                  ? user!.displayName!
                  : "Name Not Available", // Fallback to "Name Not Available"
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? "Email Not Available",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              width: 170,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Updateprofile(
                              user: user,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  side: BorderSide.none,
                  shape: StadiumBorder(),
                ),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Profile list items
            ProfileListItem(
              title: "Settings",
              icon: LineAwesomeIcons.cog_solid,
              onPress: () {},
            ),
            ProfileListItem(
              title: "Billing Details",
              icon: LineAwesomeIcons.wallet_solid,
              onPress: () {},
            ),
            ProfileListItem(
              title: "Notifications",
              icon: LineAwesomeIcons.bell,
              onPress: () {},
            ),
            ProfileListItem(
              title: "User Management",
              icon: LineAwesomeIcons.lock_open_solid,
              onPress: () {},
            ),
            const SizedBox(height: 30),
            ProfileListItem(
              title: "Help & Support",
              icon: LineAwesomeIcons.life_ring,
              onPress: () {},
            ),
            ProfileListItem(
              title: "Logout",
              icon: LineAwesomeIcons.sign_out_alt_solid,
              onPress: () => logout(context),
              textcolor: Colors.red,
              endicon: false,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endicon = true,
    this.textcolor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endicon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.15),
        ),
        child: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
            .apply(color: textcolor),
      ),
      trailing: endicon
          ? Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.15),
              ),
              child: Icon(
                LineAwesomeIcons.angle_right_solid,
                color:
                    const Color.fromARGB(255, 145, 142, 142).withOpacity(0.8),
              ),
            )
          : null,
    );
  }
}
