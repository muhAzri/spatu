import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/widgets/buttons.dart';
import 'package:spatu/view/widgets/product_card.dart';

import '../../widgets/brand_item.dart';
import '../../widgets/search_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        const SearchAppBar(),
        _buildSpecialOfferSection(),
        _buildBrandCategoriesSection(),
        _buildBrandCategoriesList(),
        _buildMostPopularSection()
      ],
    );
  }

  Widget _buildSpecialOfferSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpecialOfferTitle(),
        _buildSpecialOfferBanner(),
      ],
    );
  }

  Widget _buildSpecialOfferTitle() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Special Offers',
            style: primaryTextStyle.copyWith(fontSize: 16.sp),
          ),
          SeeAllButton(
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOfferBanner() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Image.asset(
        'assets/images/special_offer_banner.png',
        width: double.infinity,
      ),
    );
  }

  Widget _buildBrandCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandCategoriesTitle(),
      ],
    );
  }

  Widget _buildBrandCategoriesTitle() {
    return Container(
      margin: EdgeInsets.only(top: 36.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Brand Categories',
            style: primaryTextStyle.copyWith(fontSize: 16.sp),
          ),
          SeeAllButton(
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCategoriesList() {
    return Container(
      margin: EdgeInsets.only(
        top: 16.h,
      ),
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BrandItem(
            name: 'Adidas',
            imageUrl: 'assets/images/company_logo.png',
          ),
          BrandItem(
            name: 'Puma',
            imageUrl: 'assets/images/company_logo.png',
          ),
          BrandItem(
            name: 'Nike',
            imageUrl: 'assets/images/company_logo.png',
          ),
          BrandItem(
            name: 'Reebok',
            imageUrl: 'assets/images/company_logo.png',
          ),
        ],
      ),
    );
  }

  Widget _buildMostPopularSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMostPopularTitle(),
        _buildMostPopularContent(),
      ],
    );
  }

  Widget _buildMostPopularTitle() {
    return Container(
      margin: EdgeInsets.only(top: 36.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Most Populars',
            style: primaryTextStyle.copyWith(fontSize: 16.sp),
          ),
          SeeAllButton(
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMostPopularContent() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Wrap(
        runSpacing: 20.h,
        spacing: 16.w,
        children: const [
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
        ],
      ),
    );
  }
}
