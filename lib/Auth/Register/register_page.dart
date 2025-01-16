import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Auth/Register/Register_Cubit/register_cubit.dart';
import 'package:shop_app/Auth/Register/Register_Cubit/register_states.dart';
import 'package:shop_app/Shared/cache_helper.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/home_layout.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessApiState) {
            if (state.registerModel.status) {
              CacheHelper.setData(
                      key: 'token', value: state.registerModel.data?.token)
                  .then((onValue) {
                token = state.registerModel.data!.token;
                navigatorToAndKill(
                    context: context, pageRoute: const HomeLayout());
              });
              showToast(
                msg: state.registerModel.message,
                color: Colors.green,
              );
            } else {
              showToast(
                msg: state.registerModel.message,
                color: Colors.red,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 0),
                        child: Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 40,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name is Empty';
                            }
                            return null;
                          },
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 22,
                                  ),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fillColor: defualLightColor,
                            filled: true,
                            labelText: 'User Name',
                            hintText: 'amirkhairy',
                            hintStyle: const TextStyle(
                                color: Colors.white38, fontSize: 22),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone is Empty';
                            }
                            return null;
                          },
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 22,
                                  ),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            fillColor: defualLightColor,
                            filled: true,
                            labelText: 'Phone Number',
                            hintText: '01032078026',
                            hintStyle: const TextStyle(
                                color: Colors.white38, fontSize: 22),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Address is Empty';
                            }
                            return null;
                          },
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
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
                              Icons.email,
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
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is Empty';
                            }
                            return null;
                          },
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 22,
                                  ),
                          obscureText: RegisterCubit.get(context).isPassword,
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
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                RegisterCubit.get(context)
                                    .changeRegisterPasswordIcon();
                              },
                              icon: RegisterCubit.get(context).isPassword
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
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
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
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
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
                                condition: state is! RegisterLoadingApiState,
                                builder: (context) => Text(
                                  'SignUp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: 22,
                                      ),
                                ),
                                fallback: (context) =>
                                    CircularProgressIndicator(
                                  color: Theme.of(context)
                                      .progressIndicatorTheme
                                      .color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
