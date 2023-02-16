import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/pages/authentication/sign_in_page.dart';
import 'package:spatu/view/pages/authentication/sign_up_page.dart';
import 'package:spatu/view/pages/cart_page.dart';
import 'package:spatu/view/pages/main/main_page.dart';
import 'package:spatu/view/pages/splash_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const SplashPage(),
            '/sign-up': (context) => const SignUpPage(),
            '/sign-in': (context) => const SignInPage(),
            '/main': (context) => const MainPage(),
            '/cart': (context) => const CartPage(),
          },
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor1,
          ),
        );
      },
    );
  }
}
