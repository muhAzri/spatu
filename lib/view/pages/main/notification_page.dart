import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

import '../../widgets/notification_tile.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: [
          _buildTitleRow(),
          _buildDivider(),
          _buildNotificationList(),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return Container(
      margin: EdgeInsets.only(top: 27.h),
      child: Row(
        children: [
          _buildTitleText(),
          _buildSettingsIcon(),
        ],
      ),
    );
  }

  Widget _buildTitleText() {
    return Expanded(
      child: Text(
        'Notification',
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildSettingsIcon() {
    return GestureDetector(
      child: Image.asset(
        'assets/icons/settings.png',
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Divider(
        color: strokeColor,
        thickness: 2,
      ),
    );
  }

  Widget _buildNotificationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        NotificationByTimeList(
          title: 'Today',
        ),
        NotificationByTimeList(
          title: 'Yesterday',
        ),
      ],
    );
  }
}

class NotificationByTimeList extends StatelessWidget {
  final String title;

  const NotificationByTimeList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return _buildNotificationList();
  }

  Widget _buildNotificationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNotificationTime(),
        _buildNotificationCardList(),
      ],
    );
  }

  Widget _buildNotificationTime() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Text(
        title,
        style: primaryTextStyle.copyWith(
          fontSize: 15.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildNotificationCardList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        NotificationTile(),
        NotificationTile(),
      ],
    );
  }
}
