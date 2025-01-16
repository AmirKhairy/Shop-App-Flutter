import 'package:shop_app/Data_Models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordIcon extends LoginStates {}

class LoginLoadingApiState extends LoginStates {}

class LoginSuccessApiState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessApiState({required this.loginModel});
}

class LoginErrorApiState extends LoginStates {
  final String error;

  LoginErrorApiState({required this.error});
}


