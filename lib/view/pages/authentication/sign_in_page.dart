import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/models/form_model/sign_in_form_model.dart';
import 'package:spatu/shared/method.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../shared/theme.dart';
import '../../widgets/buttons.dart';
import '../../widgets/forms.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
      body: _buildBody(),
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
          _buildLoginButton(),
          _buildSignUpButton(),
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
        'Welcome Back!',
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
        'Sign In to your account',
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
            prefixUrl: 'assets/icons/mail.png',
            hintText: 'Type your email',
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

  Widget _buildLoginButton() {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          User? user = FirebaseAuth.instance.currentUser;

          context.read<UserBloc>().add(GetCurrentUser(user!.uid));
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        }

        if (state is AuthFailed) {
          showCustomSnackbar(context, state.e);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 87.h),
        child: CustomTextButton(
          title: 'Sign In',
          onTap: () {
            if (validate()) {
              context.read<AuthBloc>().add(
                    AuthSignIn(
                      SignInFormModel(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    ),
                  );
            } else {
              showCustomSnackbar(context, "Field tidak boleh Kosong");
            }
          },
        ),
      ),
    );
  }

  bool validate() {
    if (emailController.text.isNotEmpty || passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/sign-up');
      },
      child: Container(
        margin: EdgeInsets.only(top: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dont have account? ',
              style: primaryTextStyle.copyWith(
                fontWeight: light,
              ),
            ),
            Text(
              'Sign Up',
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
