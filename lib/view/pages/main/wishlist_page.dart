import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/wishlist/wishlist_cubit.dart';
import 'package:spatu/view/pages/main/main_page.dart';

import '../../../shared/theme.dart';
import '../../widgets/search_appbar.dart';
import '../../widgets/wishlist_item.dart';

class WishlistPage extends StatelessWidget {
  final VoidCallback onSearchTapped;
  const WishlistPage({super.key, required this.onSearchTapped});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        GestureDetector(
          onTap: onSearchTapped,
          child: Stack(
            children: [
              Container(),
              const SearchAppBar(),
            ],
          ),
        ),
        _buildWishlistTitle(),
        _buildWishlistList(),
      ],
    );
  }

  Widget _buildWishlistEmpty(BuildContext context) {
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
            "Oops! Your wishlist is empty",
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
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const MainPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
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

  Widget _buildWishlistTitle() {
    return Container(
      margin: EdgeInsets.only(top: 36.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your Wishlist Product',
            style: primaryTextStyle.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistList() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state.wishlist.isEmpty) {
            return _buildWishlistEmpty(context);
          }
          return Column(
            children: state.wishlist
                .map((wishlist) => WishlistItem(product: wishlist))
                .toList(),
          );
        },
      ),
    );
  }
}
