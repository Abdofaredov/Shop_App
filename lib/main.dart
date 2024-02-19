import 'package:abdo123/layout/shop_app/cubit.dart';
import 'package:abdo123/layout/shop_app/shop_layout.dart';
import 'package:abdo123/modules/shop_app/login/shop_login_screen.dart';
import 'package:abdo123/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:abdo123/shared/bloc_observer.dart';
import 'package:abdo123/shared/components/constants.dart';
import 'package:abdo123/shared/network/local/cache_helper.dart';
import 'package:abdo123/shared/network/remote/dio_helper.dart';
import 'package:abdo123/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // بيتأكد من كل حاجه هنا في المثيود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;

  token = CacheHelper.getData(key: 'token');
  // print(token);

  uId = CacheHelper.getData(key: 'uId');

  if (onBoarding) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({
    super.key,
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopLayoutCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData(),
          ),
        ],
        child: MaterialApp(
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          home: startWidget,
        ));
  }
}
