import 'package:flutter/material.dart';
import 'package:newsapp/core/services/hive_service.dart';
import 'package:newsapp/onboarding/screens/onboarding_screen.dart';
import 'package:newsapp/screen/Home_Screen.dart';

/// App entry point.
///
/// Must be `async` because we need to `await` two things before the UI starts:
///   1. [WidgetsFlutterBinding.ensureInitialized] — required by Flutter before
///      any async work or platform-channel calls in `main()`.
///   2. [HiveService.init] — opens the Hive storage box so we can read the
///      `isFirstTime` flag synchronously inside [MyApp.build].
Future<void> main() async {
  // Ensures Flutter's engine is ready before we do any async or native work.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open the storage box.
  // This must finish BEFORE runApp() so the first-launch check works immediately.
  await HiveService.init();

  runApp(const MyApp());
}

/// Root widget of the application.
///
/// Decides the **initial route** based on the Hive flag:
/// - First launch  → [OnboardingScreen]
/// - Return visit  → [HomeScreen]
///
/// This widget is [StatelessWidget] because it only needs to read a value once;
/// there is no state that changes while it is alive.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),

      // ── Initial route decision ─────────────────────────────────────────────
      // HiveService.isFirstTime reads from the already-opened Hive box.
      // If the key was never set (fresh install) → defaults to true → Onboarding.
      // If the user previously completed onboarding → false → HomeScreen.
      home:
          HiveService.isFirstTime
              ? const OnboardingScreen()
              : const HomeScreen(),
    );
  }
}
