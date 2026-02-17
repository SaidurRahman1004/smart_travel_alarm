import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_travel_alarm/common_widgets/alarm_list_item.dart';
import 'package:smart_travel_alarm/constants/app_colors.dart';
import 'package:smart_travel_alarm/constants/app_strings.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  //dummy
  final Map<int, bool> _alarmStatus = {0: true, 1: false, 2: true};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientEnd,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        onPressed: () {},
        backgroundColor: AppColors.primaryButton,
        child: Icon(Icons.add, color: AppColors.textWhite, size: 32.r),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    AppStrings.selectedLocation,
                    style: AppTextStyles.headline1.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    style: AppTextStyles.subtitle1,
                    decoration: InputDecoration(
                      hintText: AppStrings.addYourLocation,
                      hintStyle: AppTextStyles.subtitle1
                          .copyWith(
                          color: AppColors.textSecondary.withAlpha(128)),
                      prefixIcon: Icon(Icons.location_on_outlined,
                          color: AppColors.textSecondary, size: 24.r),
                      filled: true,
                      fillColor: AppColors.gradientStart.withAlpha(204),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    AppStrings.alarms,
                    style: AppTextStyles.headline1.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 16.h),
                  AlarmListItem(
                    time: '7:10 pm',
                    date: 'Fri 21 Mar 2025',
                    isActive: _alarmStatus[0]!,
                    onChanged: (value) => setState(() => _alarmStatus[0] = value),
                  ),
                  AlarmListItem(
                    time: '6:55 pm',
                    date: 'Fri 21 Mar 2025',
                    isActive: _alarmStatus[1]!,
                    onChanged: (value) => setState(() => _alarmStatus[1] = value),
                  ),
                  AlarmListItem(
                    time: '7:10 pm',
                    date: 'Fri 21 Mar 2025',
                    isActive: _alarmStatus[2]!,
                    onChanged: (value) => setState(() => _alarmStatus[2] = value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}