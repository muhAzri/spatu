import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/view/widgets/product_card.dart';

import '../../shared/theme.dart';

class RecomendationWidget extends StatelessWidget {
  const RecomendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRecomendationTitle(),
        // _buildRecomendationContent(),
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

  // Widget _buildRecomendationContent() {
  //   return Container(
  //     margin: EdgeInsets.only(top: 16.h),
  //     child: Wrap(
  //       runSpacing: 20.h,
  //       spacing: 16.w,
  //       children: const [
  //         ProductCard(),
  //         ProductCard(),
  //         ProductCard(),
  //         ProductCard(),
  //       ],
  //     ),
  //   );
  // }
}
