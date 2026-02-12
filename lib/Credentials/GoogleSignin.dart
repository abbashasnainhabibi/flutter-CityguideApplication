
import 'package:cityguide/Credentials/database.dart';
import 'package:cityguide/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Sign out from the previous account
      await googleSignIn.signOut();

      // Initiate the sign-in process
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      // If the user cancels the sign-in
      if (googleSignInAccount == null) {
        // The user canceled the sign-in
        return;
      }

      // Obtain the authentication details
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Sign in to Firebase with the credential
      UserCredential result = await auth.signInWithCredential(credential);
      User? userDetails = result.user;

      // Check if the sign-in was successful
      if (userDetails != null) {
        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL,
          "id": userDetails.uid,
        };
        await DatabaseMethods().adduser(userDetails.uid, userInfoMap);
        
        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHomeScreen()),
        );
      }
    } catch (error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error signing in: $error"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
