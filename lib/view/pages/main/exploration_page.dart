import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/product/product_bloc.dart';
import 'package:spatu/view/widgets/product_tile.dart';
import 'package:spatu/view/widgets/recomendation_widget.dart';

import '../../../shared/theme.dart';
import '../../widgets/search_appbar.dart';

class ExplorationPage extends StatefulWidget {
  const ExplorationPage({super.key});

  @override
  State<ExplorationPage> createState() => _ExplorationPageState();
}

class _ExplorationPageState extends State<ExplorationPage> {
  final TextEditingController searchController =
      TextEditingController(text: '');

  late ProductBloc prodBloc;

  @override
  void initState() {
    prodBloc = context.read<ProductBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        SearchAppBar(
          searchController: searchController,
          onFieldSubmited: (value) {
            if (value.isNotEmpty) {
              prodBloc.add(SearchProductEvent(value));
            }
            setState(() {});
          },
        ),
        searchController.text.isEmpty
            ? const RecomendationWidget()
            : _buildSearchResult(),
      ],
    );
  }

  Widget _buildSearchResult() {
    Widget foundOrNot(
        {required bool condition, required ProductSearchSuccess state}) {
      if (condition) {
        return _buildSearchNotFound();
      }

      return _buildSearchResultList(state: state);
    }

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductSearchSuccess) {
          return Column(
            children: [
              _buildSearchResultTitle(),
              foundOrNot(
                condition: state.products.isEmpty,
                state: state,
              ),
            ],
          );
        }

        return const SizedBox();
      },
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

  Widget _buildSearchResultList({required ProductSearchSuccess state}) {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Column(
        children: state.products
            .map((product) => ProductTile(product: product))
            .toList(),
      ),
    );
  }
}
