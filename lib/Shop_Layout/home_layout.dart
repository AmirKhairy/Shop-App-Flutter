import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Shop_Layout/Search_Page/search_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc.get(context).getHomeData();
    HomeBloc.get(context).getCatigoriesData();
    HomeBloc.get(context).getFavoritesData();
    HomeBloc.get(context).getProfileData();
    return BlocConsumer<HomeBloc, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Syntax Store',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 25),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigatorTo(context: context, pageRoute: SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
              ],
            ),
            body: cubit.homeScreens[cubit.currnetIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currnetIndex,
              onTap: (index) {
                cubit.changeBottomNavBarIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  backgroundColor: defualLightColor,
                  label: 'Home',
                  icon: const Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  backgroundColor: defualLightColor,
                  label: 'Catigories',
                  icon: const Icon(Icons.category),
                ),
                BottomNavigationBarItem(
                  backgroundColor: defualLightColor,
                  label: 'Favorites',
                  icon: const Icon(Icons.favorite),
                ),
                BottomNavigationBarItem(
                  backgroundColor: defualLightColor,
                  label: 'Settings',
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          );
        });
  }
}
