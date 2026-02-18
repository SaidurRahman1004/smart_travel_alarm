# Smart Travel Alarm

A Flutter-based mobile application that helps travelers stay on schedule with location-aware alarm management. Set alarms based on your current location and never miss an important moment during your journey.

## Features

- **Onboarding Experience**: Smooth introduction with three informative screens
- **Location Integration**: Automatically fetch and display your current address
- **Alarm Management**: Create, toggle, and delete alarms with an intuitive interface
- **Local Notifications**: Get notified even when the app is closed
- **Persistent Storage**: All alarms are saved locally using SQLite
- **Timezone Support**: Handles different timezones automatically
- **Responsive Design**: Adapts to different screen sizes seamlessly

## Screenshots

<p align="center">
  <img src="https://i.postimg.cc/BnQpp8tN/c1.png" width="250" />
  <img src="https://i.postimg.cc/6p5cc7Tc/c2.png" width="250" />
  <img src="https://i.postimg.cc/bwNggGdT/c3.png" width="250" />
</p>

<p align="center">
  <img src="https://i.postimg.cc/9QFbb4zr/ca5.png" width="250" />
  <img src="https://i.postimg.cc/Z5KHH90x/clf4.png" width="250" />
  <img src="https://i.postimg.cc/tCzDFdRp/datepicker.jpg" width="250" />
</p>

## Tech Stack

### Core
- **Flutter SDK** ^3.10.8
- **Dart** - Programming language

### State Management
- **provider** ^6.1.5+1 - Manages app state across widgets, handling location data and alarm lists

### UI & Styling
- **flutter_screenutil** ^5.9.3 - Makes UI responsive by scaling widgets based on screen dimensions
- **smooth_page_indicator** ^2.0.1 - Creates smooth animated dots for the onboarding carousel
- **cupertino_icons** ^1.0.8 - Provides iOS-style icons

### Location Services
- **geolocator** ^14.0.2 - Accesses device GPS to get current latitude and longitude
- **geocoding** ^4.0.0 - Converts GPS coordinates into readable street addresses

### Notifications
- **flutter_local_notifications** ^20.1.0 - Schedules and displays notifications even when app is closed
- **timezone** ^0.10.1 - Handles timezone conversions for accurate alarm scheduling
- **flutter_timezone** ^5.0.1 - Detects the device's current timezone automatically

### Data Persistence
- **sqflite** ^2.4.2 - SQLite database for storing alarms locally on device

### Date & Time
- **intl** ^0.20.2 - Formats dates and times for display (e.g., "Mon, 18 Feb")

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── constants/                         # App-wide constants
│   ├── app_colors.dart               # Color palette
│   ├── app_images.dart               # Image asset paths
│   ├── app_strings.dart              # Text strings
│   └── app_text_styles.dart          # Typography styles
├── features/
│   ├── onboarding/                   # Onboarding flow
│   │   ├── data/
│   │   │   └── onboarding_content.dart
│   │   ├── presentation/
│   │   │   └── onboarding_screen.dart
│   │   └── widgets/
│   │       └── onboarding_page.dart
│   ├── home/                         # Home screen
│   │   ├── presentation/
│   │   │   └── home_screen.dart
│   │   └── providers/
│   │       └── location_provider.dart
│   └── alarm/                        # Alarm management
│       ├── data/
│       │   └── models/
│       │       └── alarm_model.dart
│       ├── presentation/
│       │   └── alarm_screen.dart
│       └── providers/
│           └── alarm_provider.dart
├── services/                         # Backend services
│   ├── location_service.dart         # GPS & geocoding logic
│   └── notification_service.dart     # Notification scheduling
├── helpers/                          # Utility functions
│   ├── database_helper.dart          # SQLite operations
│   └── date_time_picker_helper.dart  # Date/time picker
└── common_widgets/                   # Reusable UI components
    ├── primary_button.dart
    ├── alarm_list_item.dart
    └── custo_snk.dart                # Custom snackbar
```

## Getting Started

### Prerequisites
- Flutter SDK 3.10.8 or higher
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- A physical device or emulator

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/SaidurRahman1004/smart_travel_alarm.git
cd smart_travel_alarm
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

### Platform-Specific Setup

#### Android
Add these permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
```

#### iOS
Add these keys to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location for alarm functionality.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location for alarm functionality.</string>
```

## How It Works

### 1. Onboarding
Users are greeted with three screens explaining the app's purpose. They can skip or go through each screen with smooth page transitions.

### 2. Location Access
On the home screen, users grant location permissions. The app fetches GPS coordinates and converts them to a readable address using the geocoding API.

### 3. Setting Alarms
Users can add alarms by selecting a date and time. Each alarm is:
- Stored in a local SQLite database
- Scheduled as a notification using the device's alarm manager
- Displayed in a list with toggle switches

### 4. Managing Alarms
- **Toggle**: Enable or disable alarms without deleting them
- **Delete**: Swipe left on any alarm to remove it
- Deleted or disabled alarms automatically cancel their notifications

### 5. Notifications
When an alarm time arrives, the app triggers a high-priority notification with sound and vibration, even if the app is closed.

## Key Features Explained

### Provider Architecture
The app uses the Provider pattern for state management:
- `LocationProvider` handles GPS data and loading states
- `AlarmProvider` manages alarm CRUD operations and notification scheduling

### Database Schema
```sql
CREATE TABLE alarms (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  dateTime TEXT NOT NULL,
  isActive INTEGER NOT NULL
)
```

### Notification Handling
- Uses `zonedSchedule` for timezone-aware alarms
- Automatically requests exact alarm permissions on Android 12+
- Creates a dedicated notification channel for alarms

## Troubleshooting

**Location not working?**
- Ensure location services are enabled on your device
- Check that permissions are granted in app settings

**Notifications not showing?**
- Verify notification permissions are enabled
- On Android 12+, check "Alarms & reminders" permission

**App crashing on start?**
- Run `flutter clean` then `flutter pub get`
- Check that all assets exist in the `assets/` folder




