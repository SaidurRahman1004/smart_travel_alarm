import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
//through Figma and using screenutil package for responsive
class AppTextStyles {
  static final TextStyle headline1 = TextStyle(
    fontFamily: 'Oxygen',
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );


  static final TextStyle subtitle1 = TextStyle(
    fontFamily: 'Oxygen',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );


  static final TextStyle skipButton = TextStyle(
    fontFamily: 'Oxygen',
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );

  static final TextStyle buttonText = TextStyle(
    fontFamily: 'Oxygen',
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
  );
}