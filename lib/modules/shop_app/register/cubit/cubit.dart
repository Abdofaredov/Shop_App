import 'package:abdo123/models/shop_app/login_model.dart';
import 'package:abdo123/modules/shop_app/register/cubit/states.dart';
import 'package:abdo123/shared/network/end_points.dart';
import 'package:abdo123/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  ShopLoginModel? loginModel;
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      // print(value.data);

      loginModel = ShopLoginModel.fromJson(value.data);

      // print(loginModel?.data?.token);
      // print(loginModel?.status);
      // print(loginModel?.message);

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      // print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopChangePaswordVisibilityRegisterState());
  }
}
