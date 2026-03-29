# 📍 Flutter City Guide Application

A **Flutter-based City Guide app** with Firebase backend. Explore city places, view details, navigate via maps, and submit/read reviews.

Backend handled via Firebase (Firestore / Realtime DB) with Flutter services managing all UI and logic.

---

## ⚡ Quick Start

### 1️⃣ Clone Repository
```bash
git clone https://github.com/abbashasnainhabibi/flutter-CityguideApplication.git
cd flutter-CityguideApplication
2️⃣ Install Dependencies
flutter pub get
3️⃣ Configure Firebase
Android → google-services.json → android/app/
iOS → GoogleService-Info.plist → ios/Runner/
Enable Firebase Authentication & Firestore / Realtime DB
4️⃣ Run the App
flutter run
🖼️ Screenshots
Home	Cities	Place Details	Login / Signup

	https://raw.githubusercontent.com/abbashasnainhabibi/flutter-CityguideApplication/main/screenshots/home.PNG
	
	
Profile / Admin	Reviews	Search	Signup

	
	
	
Edit Place	Delete Place	View Place	Google Login

	
	
	
Edit Review	View Review	Forgot Password	Mobile Admin

	
	
	
Edit Profile	Single City	Signup City

	
	
🎥 Demo Video

City Guide Demo

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
