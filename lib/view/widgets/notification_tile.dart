import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({super.key});

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _isLongPress = false;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (_isLongPress) {
      Timer(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }

    return Container(
      margin: EdgeInsets.only(
        top: 16.h,
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildNotificationTile(),
            _isLongPress ? _buildDeleteButton() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile() {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isLongPress = !_isLongPress;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: backgroundColor4),
          child: Row(
            children: [
              _buildNotificationImage(),
              _buildNotificationInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationImage() {
    return Container(
      width: 60.w,
      height: 60.h,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor.withOpacity(0.1),
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/discount.png',
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }

  Widget _buildNotificationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '90% Special Discount!',
          style: primaryTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: medium,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          'Special promotion only new account',
          style: secondaryTextStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: light,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      width: 52.w,
      height: 92.h,
      margin: EdgeInsets.only(left: 12.w),
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 34.h,
      ),
      decoration: BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/remove.png',
          width: 24.w,
          height: 24.h,
          color: whiteColor,
        ),
      ),
    );
  }
}
