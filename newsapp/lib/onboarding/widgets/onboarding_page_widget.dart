import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';

/// A single onboarding page widget.
///
/// Displays:
/// - A full-screen gradient background (colors come from [OnboardingModel]).
/// - An animated circular icon container as the illustration.
/// - A bold [title] and a descriptive [subtitle].
///
/// The [isVisible] flag drives an [AnimatedOpacity] fade so pages
/// smoothly appear and disappear during swipes.
class OnboardingPageWidget extends StatelessWidget {
  /// The data model holding this page's content and colors.
  final OnboardingModel page;

  /// When `false`, the page fades to transparent (used during page transitions).
  final bool isVisible;

  const OnboardingPageWidget({
    super.key,
    required this.page,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery so the layout scales correctly on all screen sizes.
    final size = MediaQuery.of(context).size;

    return AnimatedOpacity(
      // Fade in when this page becomes active, fade out when leaving.
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: double.infinity,
        height: double.infinity,

        // Full-page gradient using colors from the OnboardingModel.
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              page.primaryColor,
              page.accentColor.withValues(alpha: 0.85),
            ],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Illustration: animated icon inside a frosted circle ─────
                TweenAnimationBuilder<double>(
                  // Runs a "pop in" spring animation when the page appears.
                  tween: Tween(begin: 0.7, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut, // Spring-like overshoot effect
                  builder:
                      (_, scale, child) =>
                          Transform.scale(scale: scale, child: child),
                  child: Container(
                    // Size is proportional to the screen width for responsiveness.
                    width: size.width * 0.55,
                    height: size.width * 0.55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Semi-transparent white circle — "frosted glass" effect.
                      color: Colors.white.withValues(alpha: 0.15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 40,
                          offset: const Offset(
                            0,
                            16,
                          ), // Shadow below the circle
                        ),
                      ],
                    ),
                    child: Icon(
                      page.icon,
                      size: size.width * 0.28, // Icon scales with screen size
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.06), // Responsive vertical gap
                // ── Title ──────────────────────────────────────────────────
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                // ── Subtitle ───────────────────────────────────────────────
                Text(
                  page.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6, // Generous line height for readability
                    color: Colors.white.withValues(alpha: 0.88),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
