import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Auth/Login/login_page.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Shop_Layout/Settings_Page/edit_profile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {
        if (state is LogoutSuccessDataState) {
          navigatorToAndKill(context: context, pageRoute: LoginPage());
        }
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Theme Mode',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    HomeBloc.get(context).changeThemeMode();
                  },
                  icon: HomeBloc.get(context).isDark
                      ? const Icon(
                          Icons.dark_mode,
                        )
                      : const Icon(Icons.light_mode),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    navigatorTo(context: context, pageRoute: EditProfile());
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                HomeBloc.get(context).logout();
              },
              child: Container(
                width: width(context),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).hoverColor,
                ),
                child: Center(
                  child: ConditionalBuilder(
                    condition: state is! LogoutLoadingDataState,
                    builder: (context) => Text(
                      'Logout',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 22,
                          ),
                    ),
                    fallback: (context) => CircularProgressIndicator(
                      color: Theme.of(context).progressIndicatorTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
