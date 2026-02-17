import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_alarm/common_widgets/custo_snk.dart';
import 'package:smart_travel_alarm/common_widgets/primary_button.dart';
import 'package:smart_travel_alarm/constants/app_colors.dart';
import 'package:smart_travel_alarm/constants/app_images.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';

import '../../../constants/app_strings.dart';
import '../../alarm/presentation/ alarm_screen.dart';
import '../providers/location_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    //error message show
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (locationProvider.state == LocationFetchState.error) {
        mySnkmsg(locationProvider.errorMessage, context);
        context.read<LocationProvider>().resetState();
      }
    });
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
              //locations Adress
              if (locationProvider.state == LocationFetchState.success)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primaryButton.withOpacity(0.8),
                        size: 16.r,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          locationProvider.displayAddress,
                          style: AppTextStyles.subtitle1.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

              //Current Location
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: OutlinedButton(
                  onPressed:
                      locationProvider.state == LocationFetchState.loading
                      ? null
                      : () {
                          locationProvider.fetchLocationAndAddress();
                        },
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
                  child: locationProvider.state == LocationFetchState.loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              locationProvider.state ==
                                      LocationFetchState.success
                                  ? AppStrings.refressLocation
                                  : AppStrings.useCurrentLocation,
                              style: AppTextStyles.buttonText.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Image.asset(
                              AppImages.locationIcon,
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
                onPressed: locationProvider.state == LocationFetchState.success
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AlarmScreen()),
                  );
                }
                    : null,
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
