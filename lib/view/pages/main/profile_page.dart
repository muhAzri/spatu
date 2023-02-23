import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/auth/auth_bloc.dart';
import 'package:spatu/view/widgets/profile_item.dart';

import '../../../shared/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: [
                _buildTitle(),
                _buildImageProfile(),
                _buildUserInfo(state: state),
                _buildDivider(),
                _buildProfileMenuList(context),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(top: 27.h),
      child: Text(
        'Your Profile',
        style: primaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildImageProfile() {
    return Container(
      margin: EdgeInsets.only(
        top: 34.h,
      ),
      child: Center(
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(
            'assets/images/dummy_profile.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: _buildEditImageProfile(),
    );
  }

  Widget _buildEditImageProfile() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 34.w,
        height: 34.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
          border: Border.all(
            color: backgroundColor1,
            width: 4.w,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/icons/edit_profile.png',
            width: 24.w,
            height: 24.h,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo({required AuthSuccess state}) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        children: [
          Text(
            state.user.name == null ? state.user.username : state.user.username,
            style: primaryTextStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: medium,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            '@${state.user.username}',
            style: secondaryTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.only(top: 36.h),
      child: Divider(
        color: strokeColor,
        thickness: 2,
      ),
    );
  }

  Widget _buildProfileMenuList(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign-in', (route) => false);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 24.h),
        child: Column(
          children: [
            const ProfileItem(
              iconUrl: 'assets/icons/profile.png',
              title: 'Edit Profile',
            ),
            const ProfileItem(
              iconUrl: 'assets/icons/pin_point.png',
              title: 'My Address',
            ),
            const ProfileItem(
              iconUrl: 'assets/icons/wallet.png',
              title: 'Payment Method',
            ),
            const ProfileItem(
              iconUrl: 'assets/icons/notification.png',
              title: 'Notification Settings',
            ),
            const ProfileItem(
              iconUrl: 'assets/icons/call.png',
              title: 'Help Center',
            ),
            ProfileItem(
              iconUrl: 'assets/icons/logout.png',
              title: 'Log Out',
              isAlert: true,
              onTap: () {
                context.read<AuthBloc>().add(AuthSignOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}
