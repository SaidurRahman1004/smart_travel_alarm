import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const PrimaryButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 328.w,
      height: 56.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton,
          disabledBackgroundColor: Colors.grey.withAlpha(30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              69.r,
            ), // Adjust the radius as needed
          ),
          elevation: 5,
        ),
        child: Text(text, style: AppTextStyles.buttonText),
      ),
    );
  }
}
