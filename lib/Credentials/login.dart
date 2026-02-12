
import 'package:cityguide/ADMIN_PANEL/Home.dart';
import 'package:cityguide/Credentials/GoogleSignin.dart';
import 'package:cityguide/Credentials/Resetpassword.dart';
import 'package:cityguide/home.dart';
import 'package:cityguide/Credentials/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';


// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mylogin extends StatefulWidget {
  const Mylogin({super.key});

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  bool _isPasswordVisible = false; // Track password visibility
  final Color greenColor = const Color(0xFF1DA1F2); 

  String email = "", password = "";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

 userLogin(BuildContext context) async {
  try {
    // Firebase sign in with email and password
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    // If successful, navigate to the appropriate screen
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Login Successful",
        style: TextStyle(fontSize: 18.0),
      ),
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromRGBO(146, 208, 80, 1),
    ));

    Future.delayed(const Duration(milliseconds: 1500), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        if (user.email == "admin@gmail.com") {
          // Navigate to Admin Panel
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const AdminHomeScreen()));
        } else {
          // Navigate to User Panel
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const MainHomeScreen()));
        }
      }
    });
  } on FirebaseAuthException catch (e) {
    // Print the error code for debugging
    print('Error code: ${e.code}');

    // Handle Firebase-specific error codes
    if (e.code == 'user-not-found') {
      // When user email is not found
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 222, 4, 2),
        behavior: SnackBarBehavior.floating,
        content: Text(
          "No User Found for that Email",
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    } else if (e.code == 'invalid-email') {
      // When the password is incorrect
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 222, 4, 2),
         behavior: SnackBarBehavior.floating,
        content: Text(
          "Invalid Email",
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    } else if (e.code == 'wrong-password') {
      // When the password is incorrect
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Color.fromARGB(255, 222, 4, 2),
         behavior: SnackBarBehavior.floating,
        content: Text(
          "Wrong Password Provided",
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    } else {
      // For any other errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 222, 4, 2),
         behavior: SnackBarBehavior.floating,
        content: Text(
          "Login Failed: ${e.message}",
          style: const TextStyle(fontSize: 18.0),
        ),
      ));
    }
  } catch (e) {
    // Catch any other non-Firebase errors
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Color.fromARGB(255, 222, 4, 2),
       behavior: SnackBarBehavior.floating,
      content: Text(
        "An unexpected error occurred.",
        style: TextStyle(fontSize: 18.0),
      ),
    ));
    print('Error: $e'); // Print the error for debugging purposes
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // Add Form widget
            key: _formkey, // Assign GlobalKey to the Form
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50), // Add some space from the top

                // Logo at the top
                Image.asset(
                  'assets/images/logo4.png', // Add your logo image path here
                  height: 180, // Adjust size according to your logo
                ),
                const SizedBox(height: 20),

                // Login Text
                const Text(
                  'Login For Citi Guide',
                  style: TextStyle(
                    fontSize: 26, // Larger text size
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Username TextFormField
                TextFormField(
                  controller: emailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },

                  cursorColor: const Color.fromARGB(
                      255, 222, 4, 2), // Set the cursor color to red
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Colors.black), // Label text color to green
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5, // Thickness of border
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Default border color
                      ),
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.black), // Input text color to green
                ),
                const SizedBox(height: 20),

                // Password TextFormField
                TextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },

                  obscureText: !_isPasswordVisible,
                  cursorColor: const Color.fromARGB(255, 222, 4, 2),

                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                        color: Colors.black), // Label text color to green
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey, // Default border color
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black, // Change icon color to green
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.black), // Input text color to green
                ),
              

                // Forgot password text
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyForgotPassword()));
                    },
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 222, 4, 2),
                      ),
                    ),
                  ),
                ),
              

                // Login Button
                TextButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      // If the form is valid, store email and password
                      setState(() {
                        email = emailcontroller.text;
                        password = passwordcontroller.text;
                      });

                      // Trigger the login method
                      userLogin(context);
                    } else {
                      // Form is not valid, show error messages
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all fields"),
                          backgroundColor:  Color.fromARGB(255, 222, 4, 2),
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 2, 73, 207),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey, // Border color same as text fields
                        width: 1, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          5), // Same border radius as the input fields
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13, // Same size as the input fields text
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("or connect with"),
                      ],
                    ),
                    const SizedBox(height: 15), // Add space below the divider

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Flexible widget to prevent overflow
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              AuthMethods().signInWithGoogle(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1.5, // Border width
                                ),
                              ),
                              height: 54, // Fixed height for container
                              width: 54, // Fixed width for container
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    12), // Ensure the image also respects the container's border radius
                                child: Image.asset(
                                 'assets/images/google.png',
                                  fit: BoxFit
                                      .cover, // Ensures the image covers the entire box
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            width:
                                20), // Space between Google and Apple buttons

                        // Flexible widget to prevent overflow
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              // Implement Apple sign-in logic
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1.5, // Border width
                                ),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.apple,
                                color: Colors.black,
                                size: 25, // Icon size
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                // Sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Mysignup()));
                      },
                      child: const Text(
                        'Sign Up Now',
                        style: TextStyle(
                          color: Color.fromARGB(255, 222, 4, 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
