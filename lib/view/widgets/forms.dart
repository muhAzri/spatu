import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final String prefixUrl;
  final String hintText;
  final TextEditingController? controller;
  final bool isObsecure;
  final VoidCallback? onTap;

  const CustomTextFormField({
    super.key,
    required this.prefixUrl,
    required this.hintText,
    this.controller,
    this.isObsecure = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: grayColor,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildPrefix(),
          _buildTextFormField(),
          onTap != null ? _buildObsecureCanceler() : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildPrefix() {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      child: Image.asset(
        prefixUrl,
        width: 24.w,
        height: 24.h,
        color: grayColor,
      ),
    );
  }

  Widget _buildTextFormField() {
    return Expanded(
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        style: primaryTextStyle.copyWith(
          fontWeight: medium,
        ),
        decoration: InputDecoration.collapsed(
          hintText: hintText,
          hintStyle: secondaryTextStyle.copyWith(
            fontWeight: light,
          ),
        ),
      ),
    );
  }

  Widget _buildObsecureCanceler() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        child: Image.asset(
          'assets/icons/show_password.png',
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }
}
