import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/view/widgets/product_card.dart';

import '../../bloc/product/product_bloc.dart';
import '../../shared/theme.dart';

class RecomendationWidget extends StatelessWidget {
  const RecomendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRecomendationTitle(),
        _buildRecomendationContent(),
      ],
    );
  }

  Widget _buildRecomendationTitle() {
    return Container(
      margin: EdgeInsets.only(top: 36.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recommended',
            style: primaryTextStyle.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildRecomendationContent() {
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
                      .take(8)
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
