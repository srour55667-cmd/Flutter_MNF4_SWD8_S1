import 'package:flutter/material.dart';

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

final List<OnboardingModel> onboardingPages = const [
  OnboardingModel(
    title: 'Stay Informed',
    subtitle:
        'Get the latest breaking news from around the world, delivered to you instantly.',
    icon: Icons.newspaper_rounded,
    primaryColor: Color(0xFF1565C0),
    accentColor: Color(0xFF42A5F5),
  ),
  OnboardingModel(
    title: 'Explore Topics',
    subtitle:
        'Choose from Sports, Technology, Business, Health and many more categories you love.',
    icon: Icons.explore_rounded,
    primaryColor: Color(0xFF6A1B9A),
    accentColor: Color(0xFFAB47BC),
  ),
  OnboardingModel(
    title: 'Read Anywhere',
    subtitle:
        'Open full articles in a seamless in-app browser. No interruptions, just reading.',
    icon: Icons.auto_stories_rounded,
    primaryColor: Color(0xFF00695C),
    accentColor: Color(0xFF26A69A),
  ),
];
