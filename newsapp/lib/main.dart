import 'package:flutter/material.dart';
import 'package:newsapp/core/services/hive_service.dart';
import 'package:newsapp/onboarding/screens/onboarding_screen.dart';
import 'package:newsapp/screen/Home_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  runApp(const MyApp());
}

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
      home: HiveService.isFirstTime
          ? const OnboardingScreen()
          : const HomeScreen(),
    );
  }
}
