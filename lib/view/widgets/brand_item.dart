import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

class BrandItem extends StatelessWidget {
  final String imageUrl;
  final String name;

  const BrandItem({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          _buildBrandLogo(),
          _buildBrandTitle(),
        ],
      ),
    );
  }

  Widget _buildBrandLogo() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Image.asset(
        imageUrl,
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  Widget _buildBrandTitle() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Text(
        name,
        style: primaryTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
