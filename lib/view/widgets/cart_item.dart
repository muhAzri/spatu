import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/cart/cart_cubit.dart';
import 'package:spatu/models/cart.dart';
import 'package:spatu/shared/method.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/pages/detail_page.dart';

class CartItem extends StatefulWidget {
  final CartModel cart;

  const CartItem({super.key, required this.cart});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(product: widget.cart.product),
          ),
        );
      },
      child: Row(
        children: [
          _buildProductPicture(),
          _buildProductInfo(),
        ],
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
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.5.r),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.cart.product
            .images[widget.cart.product.colors[0].toLowerCase()][0],
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
    return SizedBox(
      width: 196.w,
      child: Text(
        widget.cart.product.name,
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
      '${widget.cart.product.brand} ·',
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
        '${widget.cart.product.soldCount} Sold',
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
        formatCurrency(number: widget.cart.product.price),
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
    return GestureDetector(
      onTap: () {
        BlocProvider.of<CartCubit>(context).removeCart(widget.cart.id);
      },
      child: Container(
        margin: EdgeInsets.only(left: 2.w),
        child: Center(
          child: Image.asset(
            'assets/icons/remove.png',
            width: 24.w,
            height: 24.h,
          ),
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
        BlocProvider.of<CartCubit>(context).reduceQuantity(widget.cart.id);
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
          '${widget.cart.quantity}',
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
        BlocProvider.of<CartCubit>(context).addQuantity(widget.cart.id);
      },
      child: Icon(
        Icons.add,
        color: whiteColor,
      ),
    );
  }
}
