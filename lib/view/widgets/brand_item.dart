import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/models/brand.dart';
import 'package:spatu/shared/theme.dart';

class BrandItem extends StatelessWidget {
  final BrandModel brand;
  const BrandItem({
    super.key,
    required this.brand,
  });

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
      child: CachedNetworkImage(
        imageUrl: brand.logoUrl,
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  Widget _buildBrandTitle() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Text(
        brand.name,
        style: primaryTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
