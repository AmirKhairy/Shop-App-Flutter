import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/Auth/Login/Login_Cubit/login_states.dart';
import 'package:shop_app/Data_Models/login_model.dart';
import 'package:shop_app/Data_Models/stripe_new_customer_model/stripe_new_customer_model.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shared/dio_helper.dart';

class LoginBloc extends Cubit<LoginStates> {
  LoginBloc() : super(LoginInitialState());

  static LoginBloc get(context) => BlocProvider.of(context);

  bool isPassword = true;
  void changePasswordIcon() {
    isPassword = !isPassword;
    emit(LoginChangePasswordIcon());
  }

  late LoginModel loginModel;
  StripeNewCustomerModel? stripeNewCustomerModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingApiState());
    DioHelper.postData(url: lOGIN, data: {
      'email': email,
      'password': password,
    }).then((onValue) {
      loginModel = LoginModel.fromJson(onValue?.data);
      token = loginModel.data?.token ?? '';

      emit(LoginSuccessApiState(loginModel: loginModel));
    }).catchError((onError) {
      log(onError.toString());
      emit(LoginErrorApiState(error: onError.toString()));
    });
  }
}
