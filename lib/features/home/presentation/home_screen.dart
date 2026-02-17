import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_travel_alarm/common_widgets/primary_button.dart';
import 'package:smart_travel_alarm/constants/app_colors.dart';
import 'package:smart_travel_alarm/constants/app_images.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';

import '../../../constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Spacer(flex: 2),
              Text(
                AppStrings.welcomeMessage,
                textAlign: TextAlign.center,
                style: AppTextStyles.headline1.copyWith(fontSize: 28.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.welcomeSubtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle1,
              ),

              SizedBox(height: 48.h),

              ClipRRect(
                child: Image.asset(
                  AppImages.homeBanner,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const Spacer(flex: 3),

              //Current Location
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textWhite,
                    side: const BorderSide(
                      color: AppColors.buttonBorder,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(69.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.useCurrentLocation,
                        style: AppTextStyles.buttonText.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Image.asset(
                        'assets/images/location_icon.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Home Button
              PrimaryButton(
                onPressed: () {

                },
                text: AppStrings.home,
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
