import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      margin: EdgeInsets.only(
        bottom: 22.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: strokeColor,
        ),
      ),
      child: Column(
        children: [
          _buildProduct(),
          _buildButtonRow(),
        ],
      ),
    );
  }

  Widget _buildProduct() {
    return Row(
      children: [
        _buildProductPicture(),
        _buildProductInfo(),
      ],
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
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.5.r),
      ),
      child: Image.asset(
        'assets/images/dummy_shoes.png',
        width: 71.4.w,
        height: 71.4.h,
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
    return Text(
      'Metcon 7',
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

  Widget _buildButtonRow() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWishlistButton(),
          _buildDeleteButton(),
          _buildQuantityButtons(),
        ],
      ),
    );
  }

  Widget _buildWishlistButton() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/heart.png',
            width: 16.w,
            height: 16.h,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            'Move to Wishlist',
            style: secondaryTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Container(
      margin: EdgeInsets.only(left: 2.w),
      child: Center(
        child: Image.asset(
          'assets/icons/remove.png',
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }

  Widget _buildQuantityButtons() {
    return Container(
      height: 28.h,
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildMinusButton(),
          _buildQuantityText(),
          _buildPlusButton(),
        ],
      ),
    );
  }

  Widget _buildMinusButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (quantity != 1) {
            quantity--;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 2000),
              content: Center(
                child: Text(
                  'Tolong Gunakan Tombol Delete Cart',
                ),
              ),
            ));
          }
        });
      },
      child: Icon(
        Icons.remove,
        color: whiteColor,
      ),
    );
  }

  Widget _buildQuantityText() {
    return SizedBox(
      width: 30.w,
      height: 18.h,
      child: Center(
        child: Text(
          '$quantity',
          style: primaryTextStyle.copyWith(
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }

  Widget _buildPlusButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          quantity++;
        });
      },
      child: Icon(
        Icons.add,
        color: whiteColor,
      ),
    );
  }
}
