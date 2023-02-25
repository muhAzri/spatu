import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/models/product.dart';
import 'package:spatu/shared/method.dart';
import 'package:spatu/shared/theme.dart';

import '../pages/detail_page.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        height: 117.h,
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: strokeColor,
          ),
        ),
        child: Row(
          children: [
            _buildProductPicture(),
            Expanded(child: _buildProductInfo()),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPicture() {
    return Container(
      width: 85.w,
      height: 85.h,
      padding: EdgeInsets.symmetric(
        horizontal: 6.8.w,
        vertical: 6.8.h,
      ),
      margin: EdgeInsets.only(
        right: 12.w,
      ),
      decoration: BoxDecoration(
          color: backgroundColor4, borderRadius: BorderRadius.circular(6.5.r)),
      // child: Image.asset(
      //   'assets/images/dummy_shoes.png',
      //   width: 71.4.w,
      //   height: 71.4.h,
      // ),
      child: Image.network(
        product.images[product.colors[0].toLowerCase()][0],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductName(),
        _buildBrandSoldRow(),
        _buildPrice(),
      ],
    );
  }

  Widget _buildProductName() {
    return SizedBox(
      width: 327.w,
      child: Text(
        product.name,
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: medium,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildBrandSoldRow() {
    return Container(
      width: 155.w,
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
      '${product.brand} ·',
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
        '${product.soldCount} Sold',
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
        formatCurrency(number: product.price),
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: medium,
        ),
      ),
    );
  }
}
