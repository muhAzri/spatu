import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/view/widgets/product_tile.dart';
import 'package:spatu/view/widgets/recomendation_widget.dart';

import '../../../shared/theme.dart';
import '../../widgets/search_appbar.dart';

class ExplorationPage extends StatelessWidget {
  const ExplorationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        const SearchAppBar(),
        _buildSearchResult(),
        const RecomendationWidget(),
      ],
    );
  }

  Widget _buildSearchResult() {
    return Column(
      children: [
        _buildSearchResultTitle(),
        _buildSearchResultList(),
        // _buildSearchNotFound(),
      ],
    );
  }

  Widget _buildSearchNotFound() {
    return Container(
      width: double.infinity,
      height: 112.h,
      margin: EdgeInsets.only(top: 24.h),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Oops! Search not found",
            style: primaryTextStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            "Try to use the right keywords again",
            style: secondaryTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: regular,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultTitle() {
    return Container(
      margin: EdgeInsets.only(top: 36.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search Result',
            style: primaryTextStyle.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultList() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Column(
        children: const [
          ProductTile(),
          ProductTile(),
        ],
      ),
    );
  }
}
