import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Data_Models/register_model.dart';
import 'package:shop_app/Auth/Register/Register_Cubit/register_states.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shared/dio_helper.dart';

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
      url: REGISTER,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      },
    ).then((onValue) {
      registerModel = RegisterModel.fromJson(onValue?.data);
      emit(RegisterSuccessApiState(registerModel: registerModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterErrorApiState(error: onError.toString()));
    });
  }
}
