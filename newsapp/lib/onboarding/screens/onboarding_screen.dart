import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:newsapp/core/services/hive_service.dart';
import 'package:newsapp/onboarding/models/onboarding_model.dart';
import 'package:newsapp/onboarding/widgets/onboarding_page_widget.dart';
import 'package:newsapp/screen/Home_Screen.dart';

/// The main onboarding screen shown only on the first app launch.
///
/// It displays a [PageView] of [OnboardingPageWidget]s, a smooth dot indicator,
/// a "Skip" button, and a "Next" / "Get Started" button.
///
/// When the user finishes or skips onboarding:
///   1. [HiveService.completeOnboarding()] is called to persist the flag.
///   2. The app navigates to [HomeScreen] with a fade + slide transition.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controls which page is currently visible in the PageView.
  final PageController _controller = PageController();

  // Tracks the index of the currently visible page (0-based).
  int _currentIndex = 0;

  @override
  void dispose() {
    // Always dispose controllers to free memory when the widget is removed.
    _controller.dispose();
    super.dispose();
  }

  // ── Navigation helpers ─────────────────────────────────────────────────────

  /// Advances to the next page, or finishes onboarding if on the last page.
  void _goNext() {
    if (_currentIndex < onboardingPages.length - 1) {
      // Animate to the next page smoothly.
      _controller.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // We're on the last page — complete onboarding and go to HomeScreen.
      _finishOnboarding();
    }
  }

  /// Saves the "onboarding done" flag and navigates to [HomeScreen].
  ///
  /// Uses [PageRouteBuilder] for a custom fade + slight-slide transition
  /// instead of the default push animation, for a polished feel.
  Future<void> _finishOnboarding() async {
    // Persist the flag so onboarding is never shown again.
    await HiveService.completeOnboarding();

    // Guard against calling Navigator after the widget has been disposed.
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),

        // Custom transition: fade in + slide slightly from the right.
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0), // Starts 5% to the right
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // True when the user is on the final page — changes button label + icon.
    final bool isLast = _currentIndex == onboardingPages.length - 1;

    // The data for the currently visible page (used for theming the button).
    final OnboardingModel activePage = onboardingPages[_currentIndex];

    return Scaffold(
      body: Stack(
        children: [
          // ── 1. Page content ────────────────────────────────────────────────
          PageView.builder(
            controller: _controller,
            itemCount: onboardingPages.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder:
                (_, i) => OnboardingPageWidget(
                  page: onboardingPages[i],
                  // Only the active page is fully opaque; others will fade out.
                  isVisible: i == _currentIndex,
                ),
          ),

          // ── 2. Skip button (top-right, hidden on the last page) ───────────
          if (!isLast)
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 16),
                  child: TextButton(
                    onPressed: _finishOnboarding, // Skip goes straight to home
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // ── 3. Bottom bar: page dots + Next/Get Started button ────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              top: false, // Only pad the bottom (avoid double-padding).
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 32,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Animated page indicator dots.
                    SmoothPageIndicator(
                      controller: _controller,
                      count: onboardingPages.length,
                      effect: ExpandingDotsEffect(
                        activeDotColor: Colors.white, // Active dot = white
                        dotColor: Colors.white38, // Inactive dots = translucent
                        dotHeight: 8,
                        dotWidth: 8,
                        expansionFactor: 3.5, // Active dot stretches wider
                        spacing: 6,
                      ),
                    ),

                    // Next / Get Started button.
                    // AnimatedContainer smoothly resizes when switching between
                    // "Next" (shorter) and "Get Started" (wider).
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _goNext,
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: isLast ? 24 : 20,
                              vertical: 14,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // AnimatedSwitcher swaps "Next" ↔ "Get Started"
                                // with a smooth cross-fade animation.
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: Text(
                                    isLast ? 'Get Started' : 'Next',
                                    key: ValueKey(isLast),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: activePage.primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                // The icon also animates between arrow and checkmark.
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: Icon(
                                    isLast
                                        ? Icons.check_circle_outline_rounded
                                        : Icons.arrow_forward_rounded,
                                    key: ValueKey(isLast),
                                    color: activePage.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
