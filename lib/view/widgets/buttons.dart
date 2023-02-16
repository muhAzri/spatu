import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

import '../../shared/method.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomTextButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 24.w,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Center(
          child: Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMyDialog(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 50.h),
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 79.5.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: const Color(0xff262832),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/images/google.png',
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              'Sign In with Google',
              style: primaryTextStyle.copyWith(
                fontWeight: light,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SeeAllButton extends StatelessWidget {
  final VoidCallback onTap;

  const SeeAllButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _buildSeeAll(),
    );
  }

  Widget _buildSeeAll() {
    return Text(
      'See All',
      style: secondaryTextStyle,
    );
  }
}
