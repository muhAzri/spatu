import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spatu/bloc/auth/auth_bloc.dart';
import 'package:spatu/bloc/cart/cart_cubit.dart';
import 'package:spatu/shared/theme.dart';
import 'package:spatu/view/pages/authentication/sign_in_page.dart';
import 'package:spatu/view/pages/authentication/sign_up_page.dart';
import 'package:spatu/view/pages/cart_page.dart';
import 'package:spatu/view/pages/main/main_page.dart';
import 'package:spatu/view/pages/profile/edit_profile_page.dart';
import 'package:spatu/view/pages/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/product/product_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'bloc/wishlist/wishlist_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider<WishlistCubit>(
          create: (context) => WishlistCubit(),
        )
      ],
      child: ScreenUtilInit(
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
              '/edit-profile': (context) => const EditProfilePage(),
            },
            theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor1,
            ),
          );
        },
      ),
    );
  }
}
