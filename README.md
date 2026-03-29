📍 Flutter City Guide Application

A Flutter-based City Guide mobile app with Firebase backend, allowing users to explore city places, view details, check reviews, and navigate via built-in maps.

🎯 Designed for real-world usage, demonstrating full-stack mobile development skills with Flutter and Firebase.

🛠️ Project Overview

City Guide App allows users to:

Discover and search city locations
View detailed information about each place
Navigate via Flutter Maps integration
Submit and read user ratings and reviews
Authenticate and store data with Firebase

This project demonstrates clean UI/UX, scalable backend, and interactive features.

📷 Screenshots
Home Screen	Map View	Place Details	Login/Register

	
	
	

Replace image links with your actual screenshots

🎥 Demo Videos
Demo	Link
App Overview	City Guide Demo

Feature Walkthrough	Optional second video
⚡ Features
Feature	Description
Clean UI	Responsive and mobile-friendly screens
Firebase Auth	Email/password login & signup
Firestore / Realtime DB	Stores places, user reviews, and favorites
Search & Filter	Quickly find places in the city
Flutter Maps	Built-in map integration for navigation
Ratings & Reviews	Submit and view user feedback
Image Carousel	Display multiple images for each place
Video Demo	Unlisted YouTube videos embedded for presentation
🛠️ Tech Stack
Language: Dart
Framework: Flutter
Backend: Firebase
Database: Firestore / Realtime DB
State Management: Provider / setState / Bloc (if applicable)
Maps Integration: Flutter Maps (Google Maps / Mapbox)
⚙️ Installation & Setup
1️⃣ Clone Repository
git clone https://github.com/abbashasnainhabibi/flutter-CityguideApplication.git
cd flutter-CityguideApplication
2️⃣ Install Dependencies
flutter pub get
3️⃣ Firebase Configuration
Create a Firebase project
Add Android & iOS apps
Download config files:
Android → google-services.json → place in android/app/
iOS → GoogleService-Info.plist → place in ios/Runner/

Enable: Firebase Authentication & Firestore / Realtime DB

4️⃣ Run the App
flutter run
📂 Project Structure
lib/
 ┣ screens/        # App screens
 ┣ widgets/        # Reusable widgets
 ┣ models/         # Data models
 ┣ services/       # Firebase & API services
 ┗ main.dart       # App entry point
assets/
 ┗ images/         # App images
pubspec.yaml       # Dependencies & assets
📈 Application Logic
User authentication checks
CRUD operations with Firebase
UI navigation to Place Details
Map display for each location
Ratings & reviews for each place
Embedded video tutorials (optional)
🧠 Future Improvements
🔔 Push notifications
🌐 Offline support
Advanced filter options

Map integration and reviews are already implemented.

👨‍💻 Author

Abbas Hasnain
GitHub: abbashasnainhabibi

Email: your email here

📄 License

This project is for learning & demonstration purposes.
