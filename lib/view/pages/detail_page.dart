import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

import '../../shared/method.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int currentIndex = 0;
  int colorIndex = 0;
  int sizeIndex = 0;

  CarouselController carouselController = CarouselController();

  List<String> images = [
    'assets/images/detail_image1.png',
    'assets/images/detail_image2.png',
    'assets/images/detail_image3.png',
    'assets/images/detail_image4.png',
    'assets/images/detail_image5.png',
  ];

  List<String> colorImages = [
    'assets/images/detail_image1.png',
    'assets/images/detail_image_color.png'
  ];

  List<String> sizeShoes = [
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _buildBottomBar(),
        backgroundColor: backgroundColor1,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 160.h,
                color: backgroundColor3,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductCard(),
                    _buildProductInformation(),
                    _buildDescription(),
                    _buildColorSelection(),
                    _buildSizeSelection(),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor3,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Details Product',
        style: primaryTextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(
          6.r,
        ),
      ),
      child: Column(
        children: [
          _buildProductImageCarousel(),
          _buildImageListRow(),
        ],
      ),
    );
  }

  Widget _buildProductImageCarousel() {
    return Center(
      child: CarouselSlider(
        carouselController: carouselController,
        items: images
            .map(
              (image) => Image.asset(
                image,
                width: 254.w,
                fit: BoxFit.cover,
              ),
            )
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildImageListRow() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: images
            .asMap()
            .map(
              (index, image) => MapEntry(
                index,
                GestureDetector(
                  onTap: () {
                    carouselController.animateToPage(index);
                  },
                  child: ImageRowItem(
                    imageUrl: image,
                    isSelected: currentIndex == index,
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }

  Widget _buildProductInformation() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          _buildProduct(),
          _buildWishlistButton(),
        ],
      ),
    );
  }

  Widget _buildProduct() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          _buildBrandRow(),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      'Metcon 8 Superblack',
      style: primaryTextStyle.copyWith(
        fontSize: 22.sp,
        fontWeight: medium,
      ),
    );
  }

  Widget _buildBrandRow() {
    return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildBrandName(),
          _buildSoldCount(),
          _buildRating(),
        ],
      ),
    );
  }

  Widget _buildBrandName() {
    return Text(
      'Nike ·',
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
        '12.512 Sold',
        style: yellowTextStyle.copyWith(
          fontSize: 12.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildRating() {
    return Container(
      margin: EdgeInsets.only(left: 4.w),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/star.png',
            width: 18.w,
            height: 18.h,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            '5.0',
            style: orangeTextStyle,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            '(6.828)',
            style: primaryTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistButton() {
    return Container(
      width: 36.w,
      height: 36.h,
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor4,
      ),
      child: Center(
        child: Image.asset(
          'assets/icons/heart.png',
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: strokeColor,
            thickness: 1.7.h,
          ),
          _buildDescTitle(),
          _buildDescContent(),
        ],
      ),
    );
  }

  Widget _buildDescTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Text(
        'Description',
        style: primaryTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
      ),
    );
  }

  Widget _buildDescContent() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Text(
        'You chase the clock, challenging and encouraging each other all in the name of achieving goals and making gains. Our go-to model for training relies on a lighter, more breathable upper than our previous edition to complement our standards of durability and comfort, so that you can float through your cardio, power through your lifts and dominate your workouts. This version has a collapsible heel that lets you step in without using your hands; then it snaps back up to secure your foot.',
        style: primaryTextStyle.copyWith(
          fontWeight: light,
        ),
        textAlign: TextAlign.left,
        maxLines: 3,
      ),
    );
  }

  Widget _buildColorSelection() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColorTitle(),
          _buildColorSelectionRow(),
        ],
      ),
    );
  }

  Widget _buildColorTitle() {
    return Text(
      'Colors Type',
      style: primaryTextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: bold,
      ),
    );
  }

  Widget _buildColorSelectionRow() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      child: Wrap(
        spacing: 12.w,
        children: colorImages
            .asMap()
            .map(
              (index, color) => MapEntry(
                index,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      colorIndex = index;
                    });
                  },
                  child: ImageRowItem(
                    imageUrl: color,
                    isSelected: colorIndex == index,
                    bgColor: backgroundColor4,
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }

  Widget _buildSizeSelection() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSizeTitle(),
          _buildSizeSelectionRow(),
        ],
      ),
    );
  }

  Widget _buildSizeTitle() {
    return Text(
      'Size (EU)',
      style: primaryTextStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: bold,
      ),
    );
  }

  Widget _buildSizeSelectionRow() {
    return Container(
      margin: EdgeInsets.only(top: 12.h, bottom: 48.h),
      child: Wrap(
        spacing: 12.w,
        runSpacing: 6.h,
        children: sizeShoes
            .asMap()
            .map(
              (index, size) => MapEntry(
                index,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      sizeIndex = index;
                    });
                  },
                  child: SizeItem(
                    size: size,
                    isSelected: sizeIndex == index,
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 108.h,
      margin: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 24.h,
      ),
      child: Column(
        children: [
          Divider(
            color: strokeColor,
            thickness: 1.7.h,
          ),
          _buildBottomContent(),
        ],
      ),
    );
  }

  Widget _buildBottomContent() {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Row(
        children: [
          _buildPricing(),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildPricing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Price',
          style: secondaryTextStyle,
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          'IDR ${formatCurrency(3195953)}',
          style: primaryTextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: medium,
          ),
        )
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 14.h,
      ),
      margin: EdgeInsets.only(left: 24.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r), color: primaryColor),
      child: Row(
        children: [
          Text(
            'Add to Cart',
            style: blackTextStyle.copyWith(fontWeight: bold),
          ),
          SizedBox(
            width: 6.w,
          ),
          Image.asset(
            'assets/icons/cart.png',
            width: 24.w,
            height: 24.h,
            color: blackColor,
          ),
        ],
      ),
    );
  }
}

class ImageRowItem extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final Color bgColor;

  const ImageRowItem({
    Key? key,
    required this.imageUrl,
    required this.isSelected,
    this.bgColor = const Color(0xff161616),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 46.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: isSelected
          ? _buildSelectedImageWidget()
          : _buildUnselectedImageWidget(),
    );
  }

  Widget _buildSelectedImageWidget() {
    return Stack(
      children: [
        Center(
          child: Image.asset(imageUrl),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: whiteColor.withOpacity(0.05),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/check.png',
                width: 20.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnselectedImageWidget() {
    return Image.asset(
      imageUrl,
    );
  }
}

class SizeItem extends StatelessWidget {
  final String size;
  final bool isSelected;

  const SizeItem({super.key, required this.size, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54.w,
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: backgroundColor4,
      ),
      child: Center(
        child: Text(
          size,
          style: _textStyle(isSelected),
        ),
      ),
    );
  }

  TextStyle _textStyle(bool isSelected) {
    if (isSelected) {
      return yellowTextStyle.copyWith(fontSize: 18.sp, fontWeight: medium);
    }
    return primaryTextStyle.copyWith(fontSize: 18.sp, fontWeight: medium);
  }
}
