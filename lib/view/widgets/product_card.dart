import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

import '../pages/detail_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  DetailPage(),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          _buildProductInfo(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: 155.w,
      height: 125.h,
      padding: EdgeInsets.symmetric(
        horizontal: 22.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Image.asset(
        'assets/images/dummy_shoes.png',
        width: 110.88.w,
        height: 105.h,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          _buildBrandSoldRow(),
          _buildPrice(),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      'Air Zoom SuperRep',
      style: primaryTextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: medium,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildBrandSoldRow() {
    return Container(
      width: 155.w,
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildBrandName(),
          _buildSoldCount(),
        ],
      ),
    );
  }

  Widget _buildBrandName() {
    return Text(
      'Nike ·',
      style: secondaryTextStyle.copyWith(
        fontWeight: medium,
      ),
    );
  }

  Widget _buildSoldCount() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      margin: EdgeInsets.only(left: 4.w),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        '52.214 Sold',
        style: yellowTextStyle.copyWith(
          fontSize: 12.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Container(
      margin: EdgeInsets.only(top: 4.h),
      child: Text(
        'IDR 1.799.000',
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: medium,
        ),
      ),
    );
  }
}
