import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      margin: EdgeInsets.only(
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff212121),
        ),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        children: [
          _buildProduct(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildProduct() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(),
        _buildProductInfo(),
      ],
    );
  }

  Widget _buildProductImage() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.5.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 6.8.w,
        vertical: 6.8.h,
      ),
      child: Image.asset(
        'assets/images/dummy_shoes.png',
        width: 71.4.w,
        height: 71.4.h,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Container(
      margin: EdgeInsets.only(left: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metcon 7',
            style: primaryTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: bold,
            ),
          ),
          _buildBrandSoldRow(),
          _buildPrice(),
        ],
      ),
    );
  }

  Widget _buildBrandSoldRow() {
    return Container(
      margin: EdgeInsets.only(top: 4.h),
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
        fontWeight: bold,
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
          fontWeight: bold,
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      margin: EdgeInsets.only(
        top: 16.h,
      ),
      child: Row(
        children: [
          _buildDeleteButton(),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      child: Container(
        width: 40.w,
        height: 40.h,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Image.asset(
          'assets/icons/remove.png',
          color: whiteColor,
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Expanded(
      child: Container(
        height: 40.h,
        margin: EdgeInsets.only(
          left: 16.w,
        ),
        padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add to Cart',
              style: blackTextStyle.copyWith(
                fontSize: 12.sp,
                fontWeight: bold,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Image.asset(
              'assets/icons/cart.png',
              width: 24.w,
              height: 24.h,
              color: blackColor,
            )
          ],
        ),
      ),
    );
  }
}
