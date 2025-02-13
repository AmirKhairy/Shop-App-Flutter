import 'package:shop_app/Data_Models/register_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangeRegisterPasswordIcon extends RegisterStates {}

class RegisterLoadingApiState extends RegisterStates {}

class RegisterSuccessApiState extends RegisterStates {
  final RegisterModel registerModel;

  RegisterSuccessApiState({required this.registerModel});
}

class RegisterErrorApiState extends RegisterStates {
  final String error;

  RegisterErrorApiState({required this.error});
}
