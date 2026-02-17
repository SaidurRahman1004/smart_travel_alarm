import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_text_styles.dart';

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onSkip;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientStart, AppColors.gradientEnd],
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Image.asset(
                  imagePath,
                  height: 400.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 20.h,
                right: 20.w,
                child: TextButton(
                  onPressed: onSkip,
                  child: Text('Skip', style: AppTextStyles.skipButton),
                ),
              ),
            ],
          ),
          SizedBox(height: 48.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.headline1,
                ),
                SizedBox(height: 16.h),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.subtitle1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
