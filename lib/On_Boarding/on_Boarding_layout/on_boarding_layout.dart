import 'package:flutter/material.dart';
import 'package:shop_app/Auth/Login/login_page.dart';
import 'package:shop_app/On_Boarding/on_Boarding_screens/first_screen.dart';
import 'package:shop_app/On_Boarding/on_Boarding_screens/second_screen.dart';
import 'package:shop_app/On_Boarding/on_Boarding_screens/third_screen.dart';
import 'package:shop_app/Shared/cache_helper.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';

class OnBoardingLayout extends StatefulWidget {
  const OnBoardingLayout({super.key});

  @override
  State<OnBoardingLayout> createState() => _OnBoardingLayoutState();
}

class _OnBoardingLayoutState extends State<OnBoardingLayout> {
  final PageController _pageController = PageController();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    children: const [
                      FirstScreen(),
                      SecondScreen(),
                      ThirdScreen(),
                    ],
                    onPageChanged: (value) {
                      setState(() {
                        index = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIndicator(active: index == 0),
                    const SizedBox(
                      width: 4,
                    ),
                    CustomIndicator(active: index == 1),
                    const SizedBox(
                      width: 4,
                    ),
                    CustomIndicator(active: index == 2),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        navigatorToAndKill(
                            context: context, pageRoute: LoginPage());
                        CacheHelper.setData(key: 'onBoarding', value: true);
                      },
                      child: Text(
                        'Skip',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: defualLightColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (index == 2) {
                          navigatorToAndKill(
                              context: context, pageRoute: LoginPage());
                          CacheHelper.setData(key: 'onBoarding', value: true);
                        } else {
                          setState(() {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.linear);
                          });
                        }
                      },
                      child: index == 2
                          ? Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: defualLightColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                            )
                          : Text(
                              'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: defualLightColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomIndicator extends StatefulWidget {
  final bool active;

  const CustomIndicator({super.key, required this.active});

  @override
  State<CustomIndicator> createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
      width: widget.active ? 25 : 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: widget.active ? defualLightColor : Colors.grey,
      ),
    );
  }
}
