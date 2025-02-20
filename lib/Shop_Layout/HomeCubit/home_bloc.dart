import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Data_Models/add_or_remove_product_in_cart_with_product_id/add_or_remove_product_in_cart_with_product_id.dart';
import 'package:shop_app/Data_Models/catigory_products_model.dart';
import 'package:shop_app/Data_Models/get_carts_model/get_carts_model.dart';
import 'package:shop_app/Data_Models/product_details_model.dart';
import 'package:shop_app/Data_Models/stripe_models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:shop_app/Shared/cache_helper.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shared/dio_helper.dart';
import 'package:shop_app/Shared/payment/stripe_service.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Data_Models/edit_profile_model.dart';
import 'package:shop_app/Data_Models/get_profile_model.dart';
import 'package:shop_app/Data_Models/add_or_delete_fav_model.dart';
import 'package:shop_app/Shop_Layout/Catigories_Page/catigories.dart';
import 'package:shop_app/Data_Models/catigories_model.dart';
import 'package:shop_app/Shop_Layout/Favorites_Page/favorites.dart';
import 'package:shop_app/Data_Models/get_favorites_model.dart';
import 'package:shop_app/Data_Models/home_model.dart';
import 'package:shop_app/Shop_Layout/Home_Page/home_products.dart';
import 'package:shop_app/Shop_Layout/Settings_Page/settings.dart';
import 'package:shop_app/Data_Models/search_model.dart';

class HomeBloc extends Cubit<HomeStates> {
  HomeBloc() : super(HomeInitialState());
  static HomeBloc get(context) => BlocProvider.of(context);

  int currnetIndex = 0;

  bool readMore = false;

  Map<int, bool> favorites = {};
  Map<String, bool> searchItems = {};

  List<Widget> homeScreens = [
    const Products(),
    const Catigories(),
    Favorites(),
    const Settings(),
  ];
  void changeBottomNavBarIndex(int index) {
    currnetIndex = index;
    emit(BottonNavBarIndexState());
  }

  void changeReadMore() {
    readMore = !readMore;
    emit(ChangeReadMoreButtonState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(HomeLoadintDataState());
    DioHelper.getData(url: hOME, token: token).then((onValue) {
      homeModel = HomeModel.fromJson(onValue?.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      }
      emit(HomeSuccessDataState());
    }).catchError((onError) {
      log(onError);
      emit(HomeErrorDataState());
    });
  }

  CatigoriesModel? catigoriesModel;
  void getCatigoriesData() {
    DioHelper.getData(url: cATIGORIES, token: token).then((onValue) {
      catigoriesModel = CatigoriesModel.fromJson(onValue?.data);
      emit(CatigoriesSuccessDataState());
    }).catchError((onError) {
      log(onError);
      emit(CatigoriesErrorDataState());
    });
  }

  GetFavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(FavoritesLoadingDataState());
    DioHelper.getData(url: fAVORITES, token: token).then((onValue) {
      favoritesModel = GetFavoritesModel.fromJson(onValue?.data);
      emit(FavoritesSuccessDataState());
    }).catchError((onError) {
      log('Get Favorite Items Error is : $onError');
      emit(FavoritesErrorDataState());
    });
  }

  AddOrDeleteFavModel? addOrDeleteFavModel;

  void changeFavoriteItem(int id) {
    favorites[id] = !favorites[id]!;
    emit(ChangeFavIconState());
    DioHelper.postData(
      url: fAVORITES,
      data: {
        'product_id': id,
        'token': token,
      },
      token: token,
    ).then((onValue) {
      addOrDeleteFavModel = AddOrDeleteFavModel.fromJson(onValue!.data);
      if (addOrDeleteFavModel!.status!) {
        getFavoritesData();

        emit(ChangeFavoriteItemSuccessState());
      } else {
        favorites[id] = !favorites[id]!;
        emit(ChangeFavIconState());
        showToast(
          msg: addOrDeleteFavModel!.message!,
          color: Colors.red,
        );
      }
    }).catchError((onError) {
      log('Change favorite item Error :${onError.toString()}');
      favorites[id] = !favorites[id]!;
      emit(ChangeFavIconState());
      showToast(
        msg: onError.toString(),
        color: Colors.red,
      );
      emit(ChangeFavoriteItemErrorState());
    });
  }

  GetProfileModel? profileModel;
  void getProfileData() {
    emit(GetProfileLoadingDataState());
    DioHelper.getData(
      url: pROFILE,
      token: token,
    ).then((onValue) {
      profileModel = GetProfileModel.fromJson(onValue!.data);
    }).catchError((onError) {
      log(onError.toString());
      emit(GetProfileErrorDataState());
    });
  }

  EditProfileModel? updateProfileModel;
  void updateProfileData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateProfileLoadingDataState());
    DioHelper.putData(
      url: uPDATEPROFILE,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
      token: token,
    ).then((onValue) {
      updateProfileModel = EditProfileModel.fromJson(onValue!.data);
      getProfileData();
      emit(UpdateProfileSuccessDataState(profileModel: updateProfileModel!));
    }).catchError((onError) {
      log(onError.toString());
      emit(UpdateProfileErrorDataState());
    });
  }

  void logout() {
    emit(LogoutLoadingDataState());
    DioHelper.postData(
      url: lOGOUT,
      data: {},
      token: token,
    ).then((onValue) {
      CacheHelper.remove(key: 'token');
      token = '';
      emit(LogoutSuccessDataState());
    }).catchError((onError) {
      log(onError.toString());
      emit(LogoutErrorDataState());
    });
  }

  SearchModel? searchModel;

  void getSearchItmes({required String text}) {
    emit(SearchLoadingDataState());
    DioHelper.postData(
      url: sEARCH,
      token: token,
      data: {'text': text},
    ).then((onValue) {
      searchModel = SearchModel.fromJson(onValue?.data);
      emit(SearchSuccessDataState());
    }).catchError((onError) {
      log('Get Search Items Error is : $onError');
      emit(SearchErrorDataState());
    });
  }

  CategoryProductsModel? catigoriesproductsModel;
  void getCatigoriesProducts({
    required int id,
  }) {
    emit(GetCategoriesProductsLoadingState());
    DioHelper.getData(
        url: pRODUCTDETAILS,
        token: token,
        query: {'category_id': '$id'}).then((onValue) {
      catigoriesproductsModel = CategoryProductsModel.fromJson(onValue?.data);
      emit(GetCategoriesProductsSuccessState());
    }).catchError((onError) {
      log('Get Catigories Products Error is : $onError');
      emit(GetCategoriesProductsErrorState());
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails({
    required int productId,
  }) {
    emit(GetProductDetailsLoadingState());
    DioHelper.getData(
      url: '$pRODUCTDETAILS/$productId',
      token: token,
      query: {'product_id': '$productId'},
    ).then((onValue) {
      productDetailsModel = ProductDetailsModel.fromJson(onValue?.data);
      emit(GetProductDetailsSuccessState());
    }).catchError((onError) {
      log('Get Product Details Error: $onError');
      emit(GetProductDetailsErrorState());
    });
  }

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  void changeThemeMode() {
    isDark = !isDark;
    CacheHelper.setData(key: 'isDark', value: isDark);
    emit(ChangeThemeMode());
  }

  GetCartsModel? getCartsModel;
  void getCarts() {
    emit(GetCartsLoadingState());
    DioHelper.getData(
      url: cARTS,
      token: token,
    ).then((onValue) {
      getCartsModel = GetCartsModel.fromJson(onValue?.data);
      emit(GetCartsSuccessState());
    }).catchError((onError) {
      log('Get Cart Error is : $onError');
      emit(GetCartsErrorState());
    });
  }

  void increaseItemQuantity({
    required int id,
    required int quantity,
  }) {
    emit(EditItemQuantityLoadingState());
    DioHelper.putData(
      url: '$updateCart$id',
      token: token,
      data: {
        'quantity': quantity,
      },
    ).then((onValue) {
      getCarts();
      emit(EditItemQuantitySuccessState());
    }).catchError((onError) {
      log('Increase Item Quantity Error is : $onError');
      emit(EditItemQuantityErrorState());
    });
  }

  AddOrRemoveProductInCartWithProductId?
      addOrRemoveProductInCartWithProductIdmodel;
  void addOrDeleteItemInCart({required int productId}) {
    emit(AddOrDeleteItemInCartLoadingState());
    DioHelper.postData(
      url: addOrDelelteItemInCart,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((onValue) {
      addOrRemoveProductInCartWithProductIdmodel =
          AddOrRemoveProductInCartWithProductId.fromJson(onValue!.data);
      getCarts();
      getProductDetails(productId: productId);

      emit(AddOrDeleteItemInCartSuccessState());
    }).catchError((onError) {
      log('Add Or Delete Item In Cart Error is : $onError');
      emit(AddOrDeleteItemInCartErrorState());
    });
  }

  final StripeService stripeService = StripeService();
  PaymentIntentInputModel? paymentIntentInputModel;
  Future? makePayment({
    required String amount,
  }) {
    emit(CardPaymentLoadingState());
    paymentIntentInputModel = PaymentIntentInputModel(
      customerId: CacheHelper.getData(key: profileModel!.data!.email),
      amount: amount,
      currency: 'USD',
    );
    stripeService
        .makePayment(paymentIntentInputModel: paymentIntentInputModel!)
        .then((onValue) {
      emit(CardPaymentSuccessState());
    }).catchError((onError) {
      log(onError);
      emit(CardPaymentErrorState());
    });
  }
}
