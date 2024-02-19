import 'package:abdo123/layout/shop_app/states.dart';
import 'package:abdo123/models/shop_app/categories_model.dart';
import 'package:abdo123/models/shop_app/change_favorites_model.dart';
import 'package:abdo123/models/shop_app/favorites_model.dart';
import 'package:abdo123/models/shop_app/home_model.dart';
import 'package:abdo123/models/shop_app/login_model.dart';
import 'package:abdo123/modules/shop_app/cateogries/cateogires_screen.dart';
import 'package:abdo123/modules/shop_app/favorites/favorites_screen.dart';
import 'package:abdo123/modules/shop_app/products/products_screen.dart';
import 'package:abdo123/modules/shop_app/settings/settings_screen.dart';
import 'package:abdo123/shared/components/constants.dart';
import 'package:abdo123/shared/network/end_points.dart';
import 'package:abdo123/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  var formKeySettings = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CateogiresScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopLayoutChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLayoutLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      // دايما متلعبش علي الاستيت وحاول تلعب علي الهوم موديل لما تيجي تستقبل الداتا لو هي فاضيه اعمل ريترن ل سيركل بروجيس اندكيتور
      // ليه منلعبش علي الاستيت لانها ممكن تتغير لاي سبب من الاسباب لكن الهوم موديل عمره ما هيتغير لانه مش هيتغير غير ب انه ممكن يبقي نل او يتملي
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel?.data?.banners?[0].image);
      // print(homeModel?.status);
      homeModel?.data?.products?.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      //  print(favorites.toString());
      emit(ShopLayoutSuccsessHomeDataState());
    }).catchError((error) {
      // print('Error: $error');
      emit(ShopLayoutErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      // دايما متلعبش علي الاستيت وحاول تلعب علي الهوم موديل لما تيجي تستقبل الداتا لو هي فاضيه اعمل ريترن ل سيركل بروجيس اندكيتور
      // ليه منلعبش علي الاستيت لانها ممكن تتغير لاي سبب من الاسباب لكن الهوم موديل عمره ما هيتغير لانه مش هيتغير غير ب انه ممكن يبقي نل او يتملي
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(homeModel?.data?.banners?[0].image);
      // print(homeModel?.status);

      emit(ShopLayoutSuccsessCategoriesDataState());
    }).catchError((error) {
      // print('Error: $error');
      emit(ShopLayoutErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productID) {
    favorites[productID] = !(favorites[productID] ?? false);
    emit(ShopLayoutChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productID},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productID] = !(favorites[productID] ?? false);
      } else {
        getFavoritesData();
      }
      emit(ShopLayoutSuccsessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productID] = !(favorites[productID] ?? false);

      emit(ShopLayoutErrorChangeFavoritesaState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLayoutLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //   print(value.data.toString());

      emit(ShopLayoutSuccsessGetFavoritesState());
    }).catchError((error) {
      // print('Error: $error');
      emit(ShopLayoutErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLayoutLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // print(userModel!.data!.name!);

      emit(ShopLayoutSuccsessUserDataState(userModel!));
    }).catchError((error) {
      // print('Error: $error');
      emit(ShopLayoutErrorUserDataState());
    });
  }

  void upDateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLayoutLoadingUpDateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // print(userModel!.data!.name!);

      emit(ShopLayoutSuccsessUpDateUserState(userModel!));
    }).catchError((error) {
      // print('Error: $error');
      emit(ShopLayoutErrorUpDateUserState());
    });
  }
}
