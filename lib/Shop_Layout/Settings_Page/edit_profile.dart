import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = HomeBloc.get(context).profileModel!.data!.name;
    phoneController.text = HomeBloc.get(context).profileModel!.data!.phone;
    emailController.text = HomeBloc.get(context).profileModel!.data!.email;
    return BlocConsumer<HomeBloc, HomeStates>(listener: (context, state) {
      if (state is UpdateProfileSuccessDataState) {
        if (state.profileModel.status) {
          showToast(
            msg: state.profileModel.message,
            color: Colors.green,
          );
        } else {
          showToast(
            msg: state.profileModel.message,
            color: Colors.red,
          );
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 25,
                ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is Empty';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 22,
                        ),
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: defualLightColor,
                      filled: true,
                      labelText: 'User Name',
                      hintText: '',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone is Empty';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 22,
                        ),
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: defualLightColor,
                      filled: true,
                      labelText: 'Phone Number',
                      hintText: '01032078026',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is Empty';
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 22,
                        ),
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        HomeBloc.get(context).updateProfileData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fillColor: defualLightColor,
                      filled: true,
                      labelText: 'Email',
                      hintText: 'amirKhairy@gmail.com',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        HomeBloc.get(context).updateProfileData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
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
                            condition: state is! UpdateProfileLoadingDataState,
                            builder: (context) => Text(
                                  'Update',
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
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
