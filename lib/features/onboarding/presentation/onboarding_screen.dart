import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:smart_travel_alarm/common_widgets/primary_button.dart';
import 'package:smart_travel_alarm/constants/app_colors.dart';
import 'package:smart_travel_alarm/features/onboarding/data/onboarding_content.dart';
import 'package:smart_travel_alarm/features/onboarding/widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    debugPrint("Skip button pressed!");
  }

  void _onNext() {
    if (_currentPage < contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      debugPrint("Get Started!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          //pageview for slideing OnboardingScreen
          PageView.builder(
            controller: _pageController,
            itemCount: contents.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final content = contents[index];
              return OnboardingPage(
                imagePath: content.image,
                title: content.title,
                description: content.description,
                onSkip: _onSkip,
              );
            },
          ),

          // Button positioned  bottom
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // Page Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: contents.length,
                    effect: WormEffect(
                      dotHeight: 8.h,
                      dotWidth: 8.w,
                      activeDotColor: AppColors.primaryButton,
                      dotColor: Colors.grey.withAlpha(20),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // Next/Get Started Button
                  PrimaryButton(
                    onPressed: _onNext,
                    text: _currentPage == contents.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}