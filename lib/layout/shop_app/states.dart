import 'package:abdo123/models/shop_app/change_favorites_model.dart';
import 'package:abdo123/models/shop_app/login_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates {}

class ShopLayoutChangeBottomNavState extends ShopLayoutStates {}

class ShopLayoutLoadingHomeDataState extends ShopLayoutStates {}

class ShopLayoutSuccsessHomeDataState extends ShopLayoutStates {}

class ShopLayoutErrorHomeDataState extends ShopLayoutStates {}

class ShopLayoutLoadingCategoriesDataState extends ShopLayoutStates {}

class ShopLayoutSuccsessCategoriesDataState extends ShopLayoutStates {}

class ShopLayoutErrorCategoriesDataState extends ShopLayoutStates {}

class ShopLayoutChangeFavoritesState extends ShopLayoutStates {}

class ShopLayoutSuccsessChangeFavoritesState extends ShopLayoutStates {
  final ChangeFavoritesModel model;

  ShopLayoutSuccsessChangeFavoritesState(this.model);
}

class ShopLayoutErrorChangeFavoritesaState extends ShopLayoutStates {}

class ShopLayoutLoadingGetFavoritesState extends ShopLayoutStates {}

class ShopLayoutSuccsessGetFavoritesState extends ShopLayoutStates {}

class ShopLayoutErrorGetFavoritesState extends ShopLayoutStates {}

class ShopLayoutLoadingUserDataState extends ShopLayoutStates {}

class ShopLayoutSuccsessUserDataState extends ShopLayoutStates {
  final ShopLoginModel loginModel;

  ShopLayoutSuccsessUserDataState(this.loginModel);
}

class ShopLayoutErrorUserDataState extends ShopLayoutStates {}

class ShopLayoutLoadingUpDateUserState extends ShopLayoutStates {}

class ShopLayoutSuccsessUpDateUserState extends ShopLayoutStates {
  final ShopLoginModel loginModel;

  ShopLayoutSuccsessUpDateUserState(this.loginModel);
}

class ShopLayoutErrorUpDateUserState extends ShopLayoutStates {}
