import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Data_Models/register_model.dart';
import 'package:shop_app/Auth/Register/Register_Cubit/register_states.dart';
import 'package:shop_app/Data_Models/stripe_new_customer_model/stripe_new_customer_model.dart';
import 'package:shop_app/Shared/cache_helper.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shared/dio_helper.dart';
import 'package:shop_app/Shared/payment/stripe_api_service.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  void changeRegisterPasswordIcon() {
    isPassword = !isPassword;
    emit(RegisterChangeRegisterPasswordIcon());
  }

  RegisterModel? registerModel;
  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingApiState());
    DioHelper.postData(
      url: rEGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((registerValue) {
      createStripeCustomer(name: name).then((newCustomerValue) {
        registerModel = RegisterModel.fromJson(registerValue?.data);
        token = registerModel?.data?.token ?? '';

        CacheHelper.setData(
          key: registerModel!.data!.email,
          value: stripeNewCustomerModel?.id,
        );
        emit(RegisterSuccessApiState(registerModel: registerModel!));
      }).catchError((onError) {
        log(onError.toString());
        emit(RegisterErrorApiState(error: onError.toString()));
      });
    }).catchError((onError) {
      log(onError.toString());
      emit(RegisterErrorApiState(error: onError.toString()));
    });
  }

  ApiService apiService = ApiService();
  StripeNewCustomerModel? stripeNewCustomerModel;
  Future<void> createStripeCustomer({required String name}) async {
    emit(CreateStripeCustomerLoadingDataState());

    try {
      final response = await apiService.post(
        url: 'https://api.stripe.com/v1/customers',
        data: {
          'name': name,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Bearer sk_test_51QqbKUH937DsZA0GMFpdJi6L15PRrxspAT7oBAyySdD0vgKl8ThxRdlqX3FiX1iBgRXG0jO6Ram7D26LmG972FTp00SfaEWd1Z', // Load from env
        },
      );

      if (response.statusCode == 200) {
        stripeNewCustomerModel = StripeNewCustomerModel.fromJson(response.data);

        emit(CreateStripeCustomerSuccessDataState());
      } else {
        log('create stripe customer error : ${response.data}');
        emit(CreateStripeCustomerErrorDataState());
      }
    } catch (e) {
      log('create stripe customer error : ${e.toString()}');
      emit(CreateStripeCustomerErrorDataState());
    }
  }
}
