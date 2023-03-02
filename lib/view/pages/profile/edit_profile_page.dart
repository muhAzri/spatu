import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/user/user_bloc.dart';
import 'package:spatu/models/form_model/edit_profile_form_model.dart';
import 'package:spatu/view/widgets/forms.dart';

import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final String userId;
  final TextEditingController _usernameController =
      TextEditingController(text: '');

  final TextEditingController _nameController = TextEditingController(text: '');

  final TextEditingController _emailController =
      TextEditingController(text: '');

  @override
  void initState() {
    final userState = context.read<UserBloc>().state;
    if (userState is UserSuccess) {
      userId = userState.user.id;
      _usernameController.text = userState.user.username;
      _nameController.text = userState.user.name ?? '';
      _emailController.text = userState.user.email;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor1,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Edit Profile',
        style: primaryTextStyle.copyWith(
          fontSize: 18.sp,
          fontWeight: medium,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: backgroundColor3,
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildForm(),
              _buildSaveButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          EditProfileFormField(
            title: 'Username',
            hintText: 'Username',
            controller: _usernameController,
          ),
          EditProfileFormField(
            title: 'Full Name',
            hintText: 'Full Name',
            controller: _nameController,
          ),
          EditProfileFormField(
            title: 'Email Address',
            hintText: 'Email Address',
            controller: _emailController,
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          Navigator.pop(context);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 24.h),
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: CustomTextButton(
          title: 'Save',
          onTap: () {
            context.read<UserBloc>().add(
                  EditProfile(
                    EditProfileFormModel(
                      id: userId,
                      username: _usernameController.text,
                      name: _nameController.text,
                      email: _emailController.text,
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }
}
