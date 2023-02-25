import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/theme.dart';

class SearchAppBar extends StatelessWidget {
  final TextEditingController? searchController;
  final Function(String value)? onFieldSubmited;

  const SearchAppBar({super.key, this.searchController, this.onFieldSubmited});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 56.h),
      child: Row(
        children: [
          _buildSearchField(),
          _buildCartButton(
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 15.5.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: backgroundColor3,
        ),
        child: Row(
          children: [
            _buildPrefix(),
            _buildTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget _buildPrefix() {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      child: Image.asset(
        'assets/icons/search.png',
        width: 24.w,
        height: 24.h,
      ),
    );
  }

  Widget _buildTextFormField() {
    return Expanded(
      child: TextFormField(
        onFieldSubmitted: onFieldSubmited,
        controller: searchController,
        style: primaryTextStyle.copyWith(
          fontWeight: medium,
        ),
        decoration: InputDecoration.collapsed(
          hintText: 'Search any product',
          hintStyle: secondaryTextStyle,
        ),
      ),
    );
  }

  Widget _buildCartButton({required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/cart');
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.w),
        child: Image.asset(
          'assets/icons/cart.png',
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }
}
