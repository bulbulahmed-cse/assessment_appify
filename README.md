# Flutter App

A clean, scalable Flutter application built using MVVM principles with BLoC, Dio, SharedPreferences and Dependency Injection.

---

##  How to Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Tech Stack

- Flutter
- Dart
- flutter_bloc
- injectable + get_it
- dio
- shared_preferences

---

## Project Architecture

```
lib/
  |---utils/             # Utilities, constants, api client
  |---modules/           # Bloc,event,state,view
  |---models/            # Model Class
  |---config/            # Dependency injection config
  |---routes/            # App routing
  |---widget/            # Custom Widget
  |---main.dart           # Entry point
```

## Features Implemented

- [x] Complete Feature with (mock API)
- [x] BLoC pattern with state handling
- [x] Token save/load via SharedPreferences
- [x] Clean Architecture with Dependency Injection

---
