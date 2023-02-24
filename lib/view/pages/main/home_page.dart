import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/widgets/buttons.dart';
import 'package:spatu/view/widgets/product_card.dart';

import '../../../bloc/brand/brand_bloc.dart';
import '../../../bloc/product/product_bloc.dart';
import '../../widgets/brand_item.dart';
import '../../widgets/search_appbar.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onSearchTapped;
  const HomePage({super.key, required this.onSearchTapped});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        GestureDetector(
          onTap: onSearchTapped,
          child: const SearchAppBar(),
        ),
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
            'Top Brands',
            style: primaryTextStyle.copyWith(fontSize: 16.sp),
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
      child: BlocProvider(
        create: (context) => BrandBloc()..add(GetBrandEvent()),
        child: BlocBuilder<BrandBloc, BrandState>(
          builder: (context, state) {
            if (state is BrandSuccess) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.brands
                    .map(
                      (brand) => BrandItem(brand: brand),
                    )
                    .toList(),
              );
            }
            return const SizedBox();
          },
        ),
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
        ],
      ),
    );
  }

  Widget _buildMostPopularContent() {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchProductEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            return Container(
              margin: EdgeInsets.only(top: 16.h),
              child: Wrap(
                  runSpacing: 20.h,
                  spacing: 16.w,
                  children: state.products
                      .take(4)
                      .map(
                        (product) => ProductCard(product: product),
                      )
                      .toList()),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
