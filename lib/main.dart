import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Auth/Login/login_page.dart';
import 'package:shop_app/On_Boarding/on_Boarding_layout/on_boarding_layout.dart';
import 'package:shop_app/Shared/Themes/themes.dart';
import 'package:shop_app/Shared/block_observer.dart';
import 'package:shop_app/Shared/cache_helper.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shared/dio_helper.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Shop_Layout/home_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  dynamic loginOrNot = CacheHelper.getData(key: 'token');

  token = CacheHelper.getData(key: 'token') ?? '';

  Widget openScreen = const OnBoardingLayout();
  if (onBoarding != null) {
    if (loginOrNot != null) {
      openScreen = const HomeLayout();
    } else {
      openScreen = LoginPage();
    }
  }

  Stripe.publishableKey =
      publishableKey;
  runApp(MyApp(
    openScreen: openScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget openScreen;

  const MyApp({
    super.key,
    required this.openScreen,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc()
            ..getHomeData()
            ..getCatigoriesData()
            ..getFavoritesData()
            ..getProfileData()
            ..getCarts(),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          final isDark = CacheHelper.getData(key: 'isDark') ?? false;
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: openScreen,
          );
        },
      ),
    );
  }
}
// SyntaxStore
