import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/cart/cart_cubit.dart';
import 'package:spatu/models/cart.dart';

import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/widgets/cart_item.dart';

import '../widgets/recomendation_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      appBar: _buildAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        children: [
          // _buildCartEmpty(context: context),
          _buildCartList(),
          const RecomendationWidget(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor1,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'My Carts',
        style: primaryTextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildCartEmpty({required BuildContext context}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24.h),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oops! Your cart is empty",
            style: primaryTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            "Lets find something for you",
            style: secondaryTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: regular,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Explore Product',
              style: yellowTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartList() {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.carts.isEmpty) {
          return _buildCartEmpty(context: context);
        }
        return Container(
          margin: EdgeInsets.only(top: 24.h),
          child: Column(
            children: state.carts
                .map(
                  (cart) => CartItem(cart: cart),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
