import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/bloc/auth/auth_bloc.dart';
import 'package:spatu/models/form_model/sign_up_form_model.dart';
import 'package:spatu/shared/method.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/widgets/forms.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../widgets/buttons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController =
      TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool isObsecure = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      showDisclaimerDialog(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            User? user = FirebaseAuth.instance.currentUser;

            context.read<UserBloc>().add(GetCurrentUser(user!.uid));

            Navigator.pushNamedAndRemoveUntil(
                context, '/main', (route) => false);
          }

          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeader(),
          _buildLoginByGoogleButton(),
          _buildLoginSeparator(),
          _buildForms(),
          _buildSignUpButton(),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      child: Column(
        children: [
          _buildLogo(),
          _buildHeaderTitle(),
          _buildHeaderSubtitle(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        width: 50.w,
        height: 50.h,
      ),
    );
  }

  Widget _buildHeaderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Text(
        'Hello Fish 👋',
        style: primaryTextStyle.copyWith(
          fontSize: 20.sp,
          fontWeight: medium,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildHeaderSubtitle() {
    return Container(
      margin: EdgeInsets.only(top: 4.h),
      child: Text(
        'Create your account & enjoy',
        style: secondaryTextStyle.copyWith(
          fontSize: 16.sp,
          fontWeight: regular,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLoginByGoogleButton() {
    return const GoogleButton();
  }

  Widget _buildLoginSeparator() {
    return Container(
      margin: EdgeInsets.only(top: 22.h),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'OR',
              style: secondaryTextStyle.copyWith(fontSize: 16.sp),
            ),
          ),
          Divider(
            color: grayColor,
          ),
        ],
      ),
    );
  }

  Widget _buildForms() {
    return Container(
      margin: EdgeInsets.only(top: 4.h),
      child: Column(
        children: [
          CustomTextFormField(
            prefixUrl: 'assets/icons/profile.png',
            hintText: 'Type your username',
            controller: usernameController,
          ),
          CustomTextFormField(
            prefixUrl: 'assets/icons/mail.png',
            hintText: 'Type your email address',
            controller: emailController,
          ),
          CustomTextFormField(
            prefixUrl: 'assets/icons/lock.png',
            hintText: 'Type your password',
            isObsecure: isObsecure,
            controller: passwordController,
            onTap: () {
              setState(
                () {
                  isObsecure = !isObsecure;
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      margin: EdgeInsets.only(top: 54.h),
      child: CustomTextButton(
        title: 'Sign Up',
        onTap: () {
          if (validate()) {
            context.read<AuthBloc>().add(
                  AuthSignUp(
                    SignUpFormModel(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  ),
                );
          } else {
            showCustomSnackbar(context, 'Field tidak boleh kosong');
          }
        },
      ),
    );
  }

  bool validate() {
    if (usernameController.text.isNotEmpty ||
        emailController.text.isNotEmpty ||
        passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: primaryTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
            Text(
              'Sign In',
              style: yellowTextStyle.copyWith(
                fontWeight: light,
              ),
            )
          ],
        ),
      ),
    );
  }
}
