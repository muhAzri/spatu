// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/models/product.dart';
import 'package:spatu/shared/theme.dart';

import '../../shared/method.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool extended = false;

  int currentIndex = 0;
  int sizeIndex = 0;

  String? selectedColorKey;
  var color;

  @override
  void initState() {
    color = widget.product.colors.first.toString().toLowerCase();
    selectedColorKey = widget.product.images.keys.toList().first;
    super.initState();
  }

  CarouselController carouselController = CarouselController();

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
        items: (widget.product.images[selectedColorKey] as List<dynamic>)
            .map(
              (image) => CachedNetworkImage(
                imageUrl: image,
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
        children: (widget.product.images[selectedColorKey] as List<dynamic>)
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
      widget.product.name,
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
      '${widget.product.brand} ·',
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
        '${formatCurrency(number: widget.product.soldCount, symbol: '')} Sold',
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
            widget.product.rating.toString(),
            style: orangeTextStyle,
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
    return GestureDetector(
      onTap: () {
        setState(() {
          extended = !extended;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 12.h),
        child: Text(
          '${widget.product.description} See More',
          style: primaryTextStyle.copyWith(
            fontWeight: light,
          ),
          textAlign: TextAlign.left,
          maxLines: extended ? null : 3,
        ),
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
        children: widget.product.images.entries
            .map((entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorKey = entry.key;
                    });
                  },
                  child: ImageRowItem(
                    imageUrl: entry.value[0],
                    isSelected: entry.key == selectedColorKey,
                    bgColor: backgroundColor4,
                  ),
                ))
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
        children: widget.product.size
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
                    size: size.toString(),
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
          formatCurrency(number: widget.product.price),
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
          child: Image.network(imageUrl),
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
    return Image.network(
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
