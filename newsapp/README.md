# 📰 News App — Flutter

A mobile news application built with Flutter. It fetches news by category and displays articles in an in-app browser. On first launch, users are greeted with a modern onboarding experience. Hive is used to remember whether the user has already seen onboarding.

---

## 📋 Table of Contents

1. [Project Structure](#-project-structure)
2. [Dependencies](#-dependencies)
3. [How Hive Works in This App](#-how-hive-works-in-this-app)
4. [Onboarding Logic — First Launch Detection](#-onboarding-logic--first-launch-detection)
5. [App Startup Flow](#-app-startup-flow-step-by-step)
6. [How to Run the Project](#-how-to-run-the-project)
7. [File Reference](#-file-reference)

---

## 📁 Project Structure

```
newsapp/
├── lib/
│   ├── main.dart                      # App entry point — Hive init + initial route
│   │
│   ├── core/
│   │   └── services/
│   │       └── hive_service.dart      # Hive wrapper (init, isFirstTime, completeOnboarding)
│   │
│   ├── onboarding/
│   │   ├── models/
│   │   │   └── onboarding_model.dart  # Data model for each onboarding page + page list
│   │   ├── screens/
│   │   │   └── onboarding_screen.dart # Main onboarding UI (PageView, dots, buttons)
│   │   └── widgets/
│   │       └── onboarding_page_widget.dart  # Single page widget (icon, title, subtitle)
│   │
│   ├── screen/
│   │   └── Home_Screen.dart           # Main news screen with category tabs
│   │
│   ├── api/
│   │   └── models.dart                # News article data model
│   │
│   ├── servec/
│   │   └── newsApp.dart               # API service — fetches news from NewsAPI
│   │
│   ├── webview/
│   │   └── webview.dart               # In-app browser for opening full articles
│   │
│   └── widget/
│       └── customwidet.dart           # Article card widget used in the news list
│
├── pubspec.yaml                       # Project dependencies and asset declarations
└── README.md                          # This file
```

> **Tip for beginners:** Start reading from `main.dart` — it is the entry point and will lead you to everything else.

---

## 📦 Dependencies

All dependencies are declared in `pubspec.yaml`.

| Package | Version | Purpose |
|---|---|---|
| `flutter` (SDK) | bundled | Core UI framework |
| `dio` | ^5.8.0 | HTTP client for fetching news from the API |
| `webview_flutter` | ^4.13.0 | Displays full articles inside the app |
| `hive_flutter` | ^1.1.0 | Lightweight local key-value storage (used for first-launch flag) |
| `smooth_page_indicator` | ^1.2.0 | Animated page dots shown at the bottom of onboarding |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |

### Install all dependencies

After cloning the project, run:

```bash
flutter pub get
```

This downloads all packages listed above automatically.

---

## 🗃️ How Hive Works in This App

[Hive](https://pub.dev/packages/hive_flutter) is a fast, lightweight key-value database that stores data locally on the device. Think of it like a dictionary that persists between app sessions.

### Initialization — `main.dart`

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before any async work
  await HiveService.init();                 // Opens the Hive box before the app starts
  runApp(const MyApp());
}
```

`HiveService.init()` must be called **before** `runApp()` so that the stored flag is available immediately when deciding which screen to show.

### The Hive Service — `lib/core/services/hive_service.dart`

```dart
class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();               // Sets up Hive with Flutter file paths
    _box = await Hive.openBox('appBox');    // Opens (or creates) a storage box
  }

  static bool get isFirstTime =>
      _box.get('isFirstTime', defaultValue: true); // Returns true if key doesn't exist yet

  static Future<void> completeOnboarding() async {
    await _box.put('isFirstTime', false);   // Permanently marks onboarding as done
  }
}
```

**Key points:**
- A Hive **box** is like a file/table that holds key-value pairs.
- `defaultValue: true` means: if the key `'isFirstTime'` has never been written, return `true` (i.e., treat it as a first launch).
- After onboarding is completed, `completeOnboarding()` writes `false` — this persists forever until the app is uninstalled.

---

## 🚀 Onboarding Logic — First Launch Detection

The onboarding screen appears **only once**, on the very first launch. Here is how that works end-to-end:

```
App Launch
    │
    ▼
HiveService.init()           ← Opens the local storage box
    │
    ▼
HiveService.isFirstTime?
    │
    ├── true  ──► OnboardingScreen   (first time ever)
    │
    └── false ──► HomeScreen         (returning user)
```

### When is the flag set to `false`?

Inside `OnboardingScreen`, two actions trigger `completeOnboarding()`:

1. **User taps "Get Started"** on the last page.
2. **User taps "Skip"** on any page.

Both call `_finishOnboarding()`:

```dart
Future<void> _finishOnboarding() async {
  await HiveService.completeOnboarding(); // Write false to Hive
  // Navigate to HomeScreen with a smooth fade + slide transition
  Navigator.of(context).pushReplacement(...);
}
```

After this, every future app launch reads `isFirstTime == false` and goes directly to `HomeScreen`.

---

## 🔄 App Startup Flow — Step by Step

```
1. Device opens the app
       ↓
2. main() runs
       ↓
3. WidgetsFlutterBinding.ensureInitialized()
       ↓
4. HiveService.init()
   └─ Hive.initFlutter() sets up the storage directory
   └─ Hive.openBox('appBox') loads the saved data
       ↓
5. runApp(MyApp()) starts the widget tree
       ↓
6. MyApp.build() checks HiveService.isFirstTime
   ├─ true  → home: OnboardingScreen()
   └─ false → home: HomeScreen()
       ↓
7a. [First launch] OnboardingScreen shows 3 pages:
    • Stay Informed   (blue gradient)
    • Explore Topics  (purple gradient)
    • Read Anywhere   (teal gradient)
       ↓
7b. User swipes or taps "Next" → "Get Started" (or "Skip")
       ↓
8.  HiveService.completeOnboarding() saves isFirstTime = false
       ↓
9.  Smooth fade + slide transition → HomeScreen
       ↓
10. [All future launches skip steps 7a-8 entirely]
```

---

## ▶️ How to Run the Project

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.7 or later)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with the Flutter extension
- A connected Android/iOS device **or** a running emulator

### Steps

```bash
# 1. Navigate to the project directory
cd d:\depi-round4\newsapp

# 2. Install all dependencies
flutter pub get

# 3. Verify there are no code issues (optional but recommended)
flutter analyze

# 4. Run the app in debug mode
flutter run
```

> **Note:** The emulator must have enough internal storage. If you see an installation error about storage, wipe the emulator data from Android Studio → Device Manager → Wipe Data.

### Reset onboarding (for testing)

To see the onboarding screen again during development, uninstall the app from the device/emulator and re-run. This clears the Hive storage:

```bash
# Uninstall then re-run
flutter run
```

---

## 📄 File Reference

| File | Responsibility |
|---|---|
| `lib/main.dart` | Async entry point. Initializes Hive, then routes to onboarding or home. |
| `lib/core/services/hive_service.dart` | All Hive logic in one place. Exposes `init()`, `isFirstTime`, and `completeOnboarding()`. |
| `lib/onboarding/models/onboarding_model.dart` | Defines the `OnboardingModel` class and the list of 3 pages with their icons, colors, and text. |
| `lib/onboarding/screens/onboarding_screen.dart` | The full onboarding UI: `PageView`, dots indicator, Skip button, Next/Get Started button, and page transition. |
| `lib/onboarding/widgets/onboarding_page_widget.dart` | A single onboarding page: gradient background, animated icon, title, and subtitle. |
| `lib/screen/Home_Screen.dart` | The main news screen. Shows articles by category using a `BottomNavigationBar`. |
| `lib/servec/newsApp.dart` | Calls the NewsAPI and returns a list of articles. |
| `lib/api/models.dart` | The `model` class representing a single news article. |
| `lib/widget/customwidet.dart` | Card widget that displays article image, title, description, author, and date. |
| `lib/webview/webview.dart` | Opens the full article URL in an in-app browser using `webview_flutter`. |

---

*Built with  Ahmed srour using Flutter*
