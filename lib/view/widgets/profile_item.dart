import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

class ProfileItem extends StatelessWidget {
  final String iconUrl;
  final String title;
  final VoidCallback? onTap;
  final bool isAlert;

  const ProfileItem({
    super.key,
    required this.iconUrl,
    required this.title,
    this.onTap,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        margin: EdgeInsets.only(bottom: 16.h),
        child: Row(
          children: [
            _buildIcon(),
            _buildTitle(),
            _buildChervoletIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Image.asset(
      iconUrl,
      width: 24.w,
      height: 24.h,
      color: isAlert ? redColor : whiteColor,
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: 20.w,
        ),
        child: Text(
          title,
          style: isAlert
              ? redTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: medium,
                )
              : primaryTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: medium,
                ),
        ),
      ),
    );
  }

  Widget _buildChervoletIcon() {
    return Icon(
      Icons.chevron_right,
      color: isAlert ? redColor : whiteColor,
      size: 30.w,
    );
  }
}
