import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Auth/Login/Login_Cubit/login_bloc.dart';
import 'package:shop_app/Auth/Login/Login_Cubit/login_states.dart';
import 'package:shop_app/Auth/Register/register_page.dart';
import 'package:shop_app/Shared/cache_helper.dart';
import 'package:shop_app/Shared/components.dart';

import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/home_layout.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessApiState) {
            if (state.loginModel.status) {
              CacheHelper.setData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((onValue) {
                token = state.loginModel.data!.token;
                navigatorToAndKill(
                  context: context,
                  pageRoute: const HomeLayout(),
                );
              });
              showToast(
                msg: state.loginModel.message,
                color: Colors.green,
              );
            } else {
              showToast(
                msg: state.loginModel.message,
                color: Colors.red,
              );
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/shop_icon2.png',
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 40),
                    child: Text(
                      'Welcome',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 36,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 40),
                    child: Text(
                      'Login to continue',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address is Empty';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 22,
                          ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fillColor: defualLightColor,
                        filled: true,
                        labelText: 'Email Address',
                        hintText: 'amirKhairy@gmail.com',
                        hintStyle: const TextStyle(
                            color: Colors.white38, fontSize: 22),
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is Empty';
                        }
                        return null;
                      },
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 22,
                          ),
                      obscureText: LoginBloc.get(context).isPassword,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fillColor: defualLightColor,
                        filled: true,
                        labelText: 'Password',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 18),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            LoginBloc.get(context).changePasswordIcon();
                          },
                          icon: LoginBloc.get(context).isPassword
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        if (formkey.currentState!.validate()) {
                          LoginBloc.get(context).userLogin(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          LoginBloc.get(context).userLogin(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
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
                            condition: state is! LoginLoadingApiState,
                            builder: (context) => Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontSize: 22,
                                  ),
                            ),
                            fallback: (context) => CircularProgressIndicator(
                              color: Theme.of(context)
                                  .progressIndicatorTheme
                                  .color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have account? ',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          navigatorTo(
                              context: context, pageRoute: RegisterPage());
                        },
                        child: const Text(
                          'Register',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
