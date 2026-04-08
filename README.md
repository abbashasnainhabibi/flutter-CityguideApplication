# City Guide App

A comprehensive Flutter mobile application for discovering locations, attractions, and services in new cities using real-time location data and Firebase integration.

## 📱 Overview

City Guide App is a location-based discovery platform built with Flutter and Firebase that helps travelers and new residents explore cities. Users can discover mountains, hotels, restaurants, and other attractions with their exact coordinates, descriptions, and detailed information.

## ✨ Features

### User Features
- **Authentication System**
  - Sign up with email and password
  - Google Sign-In integration
  - Password reset functionality via email
  - Strong password validation with security requirements

- **Location Discovery**
  - View all locations with real-time coordinates (latitude/longitude)
  - Browse attractions by category
  - View detailed information about each location
  - Access descriptions, ratings, and contact information

- **Search & Filter**
  - Search locations by name
  - Filter by category (Mountains, Hotels, Restaurants, etc.)
  - View location distance and directions
  - Save favorite locations

- **Category-Based Navigation**
  - Mountains: Hiking destinations and scenic peaks
  - Hotels: Accommodation options with details
  - Restaurants: Dining establishments and cuisine types
  - Attractions: Tourist destinations and points of interest
  - Other categories: Dynamic and expandable

- **Location Details**
  - View exact coordinates (latitude/longitude)
  - Access location descriptions
  - Contact information and operating hours
  - User reviews and ratings

### Admin Panel Features
- **City Management**
  - Add new cities to the platform
  - Edit city information and descriptions
  - Delete cities as needed

- **Geographic Hierarchy**
  - Add provinces/states to cities
  - Create relationships between cities and regions
  - Manage location territories

- **Location Management**
  - Add locations with complete details
  - Set precise coordinates (latitude/longitude)
  - Upload location images
  - Add descriptions and contact information
  - Categorize locations
  - Edit and delete locations

- **Category Management**
  - Create custom categories
  - Organize locations by type
  - Dynamic category system

## 🛠 Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase
  - Firestore Database
  - Firebase Authentication
  - Firebase Storage (for location images)
  - Firebase Geolocation
- **Maps Integration**: Google Maps or equivalent
- **IDE**: Android Studio / VS Code
- **Version Control**: Git

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (version 2.0 or higher)
- Dart SDK (included with Flutter)
- Android Studio or Xcode
- Git
- A Firebase project with geolocation enabled
- Google Maps API key (for map features)

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/city-guide-app.git
cd city-guide-app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Configuration

#### For Android:
- Download `google-services.json` from Firebase Console
- Place it in `android/app/`
- Update `android/build.gradle` with Google Services plugin

#### For iOS:
- Download `GoogleService-Info.plist` from Firebase Console
- Add it to Xcode project (iOS Runner target)

### 4. Google Maps API Setup
- Enable Google Maps SDK in Google Cloud Console
- Add API key to Android Manifest and iOS Info.plist
- Configure location permissions

### 5. Configure Firebase
- Update `lib/config/firebase_config.dart` with your credentials

### 6. Run the Application
```bash
flutter run
```

## 📖 Usage

### For Users
1. **Create Account**: Sign up with email or Google account
2. **Explore Cities**: Select a city to explore
3. **Browse by Category**: Select from Mountains, Hotels, Restaurants, etc.
4. **Search Locations**: Use the search bar to find specific places
5. **View Details**: Tap a location to see coordinates, description, and contact info
6. **Save Favorites**: Bookmark locations for future reference

### For Admins
1. **Access Admin Dashboard**: Log in with admin credentials
2. **Add Cities**: Create new cities with details
3. **Manage Provinces**: Add states/provinces to cities
4. **Add Locations**: Create locations with precise coordinates
5. **Upload Images**: Add photos for each location
6. **Manage Categories**: Create and organize location categories
7. **Edit/Delete**: Update or remove locations and cities

## 🔐 Security Features

- Strong password validation
- Secure Firebase authentication
- Location data encryption
- Email verification for password reset
- User permission handling for location access

## 📁 Project Structure
city-guide-app/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── city/
│   │   ├── location_detail/
│   │   ├── search/
│   │   └── admin/
│   ├── models/
│   ├── services/
│   │   ├── firebase_service.dart
│   │   └── location_service.dart
│   └── config/
├── android/
├── ios/
└── pubspec.yaml

## 🗺️ Supported Categories

- Mountains & Peaks
- Hotels & Accommodations
- Restaurants & Cafes
- Tourist Attractions
- Shopping Centers
- Parks & Gardens
- Historical Sites
- Entertainment Venues
- Custom categories (admin-defined)

## 🧪 Testing

```bash
flutter test
```

## 📦 Build for Release

### Android:
```bash
flutter build apk --release
```

### iOS:
```bash
flutter build ios --release
```

## 🐛 Troubleshooting

- **Location Not Showing**: Check coordinates format (latitude, longitude)
- **Maps Not Displaying**: Verify Google Maps API key is valid
- **Permission Errors**: Check Android/iOS permission configurations
- **Firebase Issues**: Ensure Firestore rules allow read/write for users

## 📝 License

Proprietary - All rights reserved.

## 👨‍💼 Author

Abbas

---

**Note**: Portfolio project demonstrating location-based services and Firebase expertise.
