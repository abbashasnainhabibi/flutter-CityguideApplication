📍 Flutter City Guide Application

A Flutter-based City Guide app with Firebase backend. Explore city places, view details, navigate via maps, and submit/read reviews.

Backend handled via Firebase (Firestore / Realtime DB) with Flutter services managing all UI and logic.

⚡ Quick Start
Clone Repository
git clone https://github.com/abbashasnainhabibi/flutter-CityguideApplication.git
cd flutter-CityguideApplication
Install Dependencies
flutter pub get
Configure Firebase
Android → google-services.json → android/app/
iOS → GoogleService-Info.plist → ios/Runner/
Enable Firebase Authentication & Firestore / Realtime DB
Run the App
flutter run
🖼️ Screenshots
Home Screen	Map Screen	Place Details	Login / Register

	
	
	

Replace image links with your actual screenshots

🎥 Demo Videos
Feature	Video
App Overview	City Guide Demo

Optional Feature Walkthrough	Add unlisted video link
🛠️ Feature Highlights
Feature	Description
Clean UI	Responsive screens for Android & iOS
Firebase Auth	Email/password login & signup
Firestore / Realtime DB	Stores places, user reviews, and favorites
Search & Filter	Quickly find places in the city
Flutter Maps	Built-in map integration for navigation
Ratings & Reviews	Submit and view user feedback
Place Details	Multiple images & descriptions per location
Video Demo	Embedded unlisted YouTube videos for presentation
📂 Project Structure
lib/
 ┣ screens/        # App screens
 ┣ widgets/        # Reusable widgets
 ┣ models/         # Data models
 ┣ services/       # Firebase & APIs
 ┗ main.dart       # Entry point
assets/
 ┗ images/         # App images
pubspec.yaml       # Dependencies & assets
💻 Useful Commands
Command	Description
flutter pub get	Install Flutter dependencies
flutter run	Run the app
Firebase Config	Place google-services.json & GoogleService-Info.plist in correct directories
🧠 Future Improvements
🔔 Push notifications
🌐 Offline support

(Maps and user reviews already implemented)

👨‍💻 Author

Abbas Hasnain
GitHub: abbashasnainhabibi

Email: your email here
