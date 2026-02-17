import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AlarmListItem extends StatelessWidget {
  final String time;
  final String date;
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const AlarmListItem({
    super.key,
    required this.time,
    required this.date,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.alarmlistCard.withAlpha(120),
        borderRadius: BorderRadius.circular(48.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: AppTextStyles.buttonText.copyWith(fontSize: 20.sp)),
          Text(date, style: AppTextStyles.subtitle1),
          Switch(
            value: isActive,
            onChanged: onChanged,
            activeTrackColor: AppColors.switchActive,
            activeColor: AppColors.textWhite,
            inactiveTrackColor: AppColors.switchInactiveTrack,
            inactiveThumbColor: AppColors.switchInactiveThumb,
          ),
        ],
      ),
    );
  }
}
