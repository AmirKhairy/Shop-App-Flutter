import 'package:shop_app/Data_Models/edit_profile_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class BottonNavBarIndexState extends HomeStates {}

class ChangeReadMoreButtonState extends HomeStates {}

class HomeLoadintDataState extends HomeStates {}

class HomeSuccessDataState extends HomeStates {}

class HomeErrorDataState extends HomeStates {}

class CatigoriesSuccessDataState extends HomeStates {}

class CatigoriesErrorDataState extends HomeStates {}

class FavoritesSuccessDataState extends HomeStates {}

class FavoritesErrorDataState extends HomeStates {}

class FavoritesLoadingDataState extends HomeStates {}

class ChangeFavIconState extends HomeStates {}

class ChangeFavoriteItemSuccessState extends HomeStates {}

class ChangeFavoriteItemErrorState extends HomeStates {}

class ChangeFavoriteItemLoadintState extends HomeStates {}

class GetProfileSuccessDataState extends HomeStates {}

class GetProfileErrorDataState extends HomeStates {}

class GetProfileLoadingDataState extends HomeStates {}

class UpdateProfileSuccessDataState extends HomeStates {
  final EditProfileModel profileModel;

  UpdateProfileSuccessDataState({required this.profileModel});
}

class UpdateProfileErrorDataState extends HomeStates {}

class UpdateProfileLoadingDataState extends HomeStates {}

class LogoutSuccessDataState extends HomeStates {}

class LogoutErrorDataState extends HomeStates {}

class LogoutLoadingDataState extends HomeStates {}

class SearchSuccessDataState extends HomeStates {}

class SearchErrorDataState extends HomeStates {}

class SearchLoadingDataState extends HomeStates {}

class ChangeThemeMode extends HomeStates {}

class GetCategoriesProductsLoadingState extends HomeStates {}

class GetCategoriesProductsSuccessState extends HomeStates {}

class GetCategoriesProductsErrorState extends HomeStates {}

class GetProductDetailsLoadingState extends HomeStates {}

class GetProductDetailsSuccessState extends HomeStates {}

class GetProductDetailsErrorState extends HomeStates {}

class GetCartsLoadingState extends HomeStates {}

class GetCartsSuccessState extends HomeStates {}

class GetCartsErrorState extends HomeStates {}

class EditItemQuantityLoadingState extends HomeStates {}

class EditItemQuantitySuccessState extends HomeStates {}

class EditItemQuantityErrorState extends HomeStates {}
