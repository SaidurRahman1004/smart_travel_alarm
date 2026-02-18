import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_travel_alarm/common_widgets/alarm_list_item.dart';
import 'package:smart_travel_alarm/common_widgets/custo_snk.dart';
import 'package:smart_travel_alarm/constants/app_colors.dart';
import 'package:smart_travel_alarm/constants/app_strings.dart';
import 'package:smart_travel_alarm/constants/app_text_styles.dart';

import '../../../helpers/date_time_picker_helper.dart';
import '../../home/providers/location_provider.dart';
import '../providers/alarm_provider.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final TextEditingController _locationController = .new();

  @override
  void initState() {
    super.initState();
    final location = context.read<LocationProvider>().displayAddress;
    _locationController.text = location;
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  //onpressed fn for FAB
  Future<void> _onAddAlarmPressed() async {
    final DateTime? scheduledDateTime = await showDateTimePicker(context);
    if (scheduledDateTime != null && mounted) {
      await context.read<AlarmProvider>().addAlarm(scheduledDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final alarmProvider = context.watch<AlarmProvider>();
    return Scaffold(
      backgroundColor: AppColors.gradientEnd,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        onPressed: _onAddAlarmPressed,
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
                    controller: _locationController,
                    readOnly: true,
                    style: AppTextStyles.subtitle1,
                    decoration: InputDecoration(
                      hintText: AppStrings.addYourLocation,
                      hintStyle: AppTextStyles.subtitle1.copyWith(
                        color: AppColors.textSecondary.withAlpha(128),
                      ),
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: AppColors.textSecondary,
                        size: 24.r,
                      ),
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
                  //show alarm
                  if (alarmProvider.alarms.isEmpty) ...[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.h),
                        child: Text(
                          AppStrings.emtyAlarm,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subtitle1,
                        ),
                      ),
                    ),
                  ] else ...[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: alarmProvider.alarms.length,
                      itemBuilder: (context, index) {
                        final alarm = alarmProvider.alarms[index];
                        return Dismissible(
                          key: Key(alarm.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            alarmProvider.deleteAlarm(alarm);
                            mySnkmsg(AppStrings.deleteAlarm, context);
                          },

                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            margin: EdgeInsets.only(bottom: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(48.r),
                            ),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                            ),
                          ),

                          child: AlarmListItem(
                            time: DateFormat('h:mm a').format(alarm.dateTime),
                            date: DateFormat('E, d MMM').format(alarm.dateTime),
                            isActive: alarm.isActive,
                            onChanged: (value) {
                              alarmProvider.toggleAlarm(alarm);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
