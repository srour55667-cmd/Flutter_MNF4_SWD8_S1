import 'package:flutter/material.dart';

/// Data model for a single onboarding page.
///
/// Each page contains:
/// - [title]        : The bold headline shown on the page.
/// - [subtitle]     : A short description shown below the title.
/// - [icon]         : A Material icon used as the page illustration.
/// - [primaryColor] : The top color of the page gradient background.
/// - [accentColor]  : The bottom color of the page gradient background.
class OnboardingModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;

  const OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primaryColor,
    required this.accentColor,
  });
}

/// The list of onboarding pages displayed to the user on first launch.
///
/// Add, remove, or reorder entries here to change the onboarding experience.
/// The [OnboardingScreen] automatically adapts to however many pages are listed.
final List<OnboardingModel> onboardingPages = const [
  // Page 1 — Blue: introduces the concept of real-time news
  OnboardingModel(
    title: 'Stay Informed',
    subtitle:
        'Get the latest breaking news from around the world, delivered to you instantly.',
    icon: Icons.newspaper_rounded,
    primaryColor: Color(0xFF1565C0), // Deep blue
    accentColor: Color(0xFF42A5F5), // Light blue
  ),

  // Page 2 — Purple: highlights the category browsing feature
  OnboardingModel(
    title: 'Explore Topics',
    subtitle:
        'Choose from Sports, Technology, Business, Health and many more categories you love.',
    icon: Icons.explore_rounded,
    primaryColor: Color(0xFF6A1B9A), // Deep purple
    accentColor: Color(0xFFAB47BC), // Orchid purple
  ),

  // Page 3 — Teal: showcases the in-app browser for reading full articles
  OnboardingModel(
    title: 'Read Anywhere',
    subtitle:
        'Open full articles in a seamless in-app browser. No interruptions, just reading.',
    icon: Icons.auto_stories_rounded,
    primaryColor: Color(0xFF00695C), // Dark teal
    accentColor: Color(0xFF26A69A), // Light teal
  ),
];
