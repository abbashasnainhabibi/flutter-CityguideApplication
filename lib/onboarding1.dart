// import 'package:cityguide/login.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:google_fonts/google_fonts.dart';


// class Onboarding extends StatelessWidget {
//   const Onboarding({super.key});

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: Column(
//         children: [
//           // Image covering 60% of the screen height
//           SizedBox(height: 5,),
//           Expanded(
//             flex: 6,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/onboard3.png'),
//                      fit: BoxFit.cover, // Ensures the image covers the container
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // White background with rounded upper corners
//           Expanded(
//             flex: 4,
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 248, 243, 255), // White background
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30), // Rounded top left corner
//                   topRight: Radius.circular(30), // Rounded top right corner
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                  Image.asset(
//   'assets/images/cityguide.png',
//   width: 200,  // Set your preferred width
//   height: 100, // Set your preferred height
//   // fit: BoxFit.contain,  // Adjust to how you want the image to fit
// ),

//                   // SizedBox(height: 5),
//                   // Padding(
//                   //   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   //   child: Text(
//                   //     // "The Premier City Tourism Guide App.\n"
//                   //     // "Seamless booking experience.\n"
//                   //     // "Get started now."
//                   //     // ,
//                   //     style: TextStyle(fontSize: 16),
//                   //     textAlign: TextAlign.center,
//                   //   ),
//                   // ),
//                   //  SizedBox(height: 20),
//                   // Rounded button with >>
//                   Container(
//                     width: 70, // Adjust width for the desired size
//                     height: 70, // Adjust height for the desired size
//                     padding:
//                         EdgeInsets.all(6), // Adjust padding for desired spacing
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Color(0xFF16423C),
//                         //  color: Color(0xFF16423C), // Blue color for the border
//                         width: 3, // Border width to make the outline visible
//                       ),
//                     ),
//                     child: MaterialButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginPage()));
//                       },
//                       shape: CircleBorder(),
//                       color: Color(0xFF16423C),
//                       // color: Color(0xFF6a9c89),
//                       padding: EdgeInsets.all(20),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.chevron_right, color: Colors.white),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
























// import 'package:flutter/material.dart';

// class Onboarding extends StatelessWidget {
//   const Onboarding({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Container(

//          child: Column(
//           children: [
//             Container(
//    height: 400,
//           width: 510,
//         decoration: BoxDecoration(
//              borderRadius: new BorderRadius.vertical(
//           bottom: Radius.elliptical(250, 40)),
//            color: Color(0xFF283E50),
//         ),
//               child: Column(
//                 children: [
//                Image.asset("assets/images/c.png",width: 400, height: 350,),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10,),
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: Text("Travel",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w700,color: Color(0xFFF25D29), ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Text("Meet New Local Residents",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,)),
//                 ),
//                 SizedBox(height: 10,),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 28),
//                   child: Center(child: Text("cityGuide is your ultimate city companion, designed to make urban exploration easy and excityng cityGuide helps you navigate and experience the city like never before.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,),)),
//                 ),
//                 SizedBox(height: 20,),
//                  Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 5),
//                             child: MaterialButton(
//                               onPressed: () {},
//                               child: Padding(
//                                 padding: const EdgeInsets.all(13.0),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 50.0),
//                                   child: Text("GO"),
//                                 ),
//                               ),
//                               height: 30,
//                               color:  Color(0xFFF25D29),
//                               textColor: const Color.fromARGB(255, 0, 0, 0),
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             ),
//                           ),
//               ],
//             )

//           ],
//          ),

//         ),

//       ),
//     );
//   }
// }















import 'package:cityguide/Credentials/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);

  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Continue!',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => Mylogin(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: kDarkBlueColor,
        
      ),
   skipTextButton: GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Mylogin(), // Replace with your Home widget
      ),
    );
  },
  child: Text(
    'Skip',
    style: TextStyle(
      fontSize: 15, // Reduced font size
      color: Color(0xFFA1A1A1).withOpacity(0.8), // Lightened color with opacity
      fontWeight: FontWeight.w400, // Lighter font weight
    ),
  ),
),


      trailing: Text(
        'Skip',
        style: TextStyle(
            fontSize: 15, // Reduced font size
    color: Color(0xFFA1A1A1).withOpacity(0.8), // Lightened color with opacity
    fontWeight: FontWeight.w400, // Lighter font weight
        ),
      ),
      controllerColor: kDarkBlueColor,
      totalPage: 3,
      headerBackgroundColor: Color(0xFF283E50),
      pageBackgroundColor: Colors.white,
      background: [
        _buildPageBackground('assets/images/c.png'),
        _buildPageBackground('assets/images/download (2).png'),
        _buildPageBackground('assets/images/p (3).png'),
      ],
      speed: 1.8,
      pageBodies: [
        _buildPageBody(
          context,
          title: 'Explore the City',
          subtitle: 'Discover top attractions, hidden gems, and local favorites all in one place.',
          description:
              "",
        ),
        _buildPageBody(
          context,
          title: 'Plan Your Visit',
          subtitle: 'Get personalized recommendations and create your ideal itinerary.',
          description:
              "",
        ),
        _buildPageBody(
          context,
          title: 'Navigate with Ease',
          subtitle: 'Access maps, directions, and real-time info to make every journey smooth.',
          description:
              "",
        ),
      ],
    );
  }

  Widget _buildPageBackground(String imagePath) {
    return Container(
      height: 350,
      width: 510,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(250, 40)),
        color: Color(0xFF283E50),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 300,
            height: 300,
          )
        ],
      ),
    );
  }

  Widget _buildPageBody(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String description,
  }) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 370),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF25D29),
                fontSize: 28.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 70, 62, 62),
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
