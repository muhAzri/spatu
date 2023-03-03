import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/cart/cart_cubit.dart';
import 'package:spatu/bloc/wishlist/wishlist_cubit.dart';
import 'package:spatu/shared/method.dart';
import 'package:spatu/shared/theme.dart';

import '../../models/product.dart';

class WishlistItem extends StatelessWidget {
  final ProductModel product;

  const WishlistItem({super.key, required this.product});

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
          _buildButtons(context),
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
      child: CachedNetworkImage(
        imageUrl: product.images[product.colors[0].toLowerCase()][0],
        width: 71.4.w,
        height: 71.4.h,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: primaryTextStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            _buildBrandSoldRow(),
            _buildPrice(),
          ],
        ),
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
      '${product.brand} ·',
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
          fontWeight: bold,
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 16.h,
      ),
      child: Row(
        children: [
          _buildDeleteButton(context),
          _buildAddToCartButton(context),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<WishlistCubit>(context).removeWishlist(product);
        showCustomSnackbar(context, '${product.name} dihapus dari Wishlist');
      },
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

  Widget _buildAddToCartButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<CartCubit>(context).addProduct(product);
          showCustomSnackbar(context, '${product.name} ditambahkan ke Cart');
        },
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
      ),
    );
  }
}
