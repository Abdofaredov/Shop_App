import 'package:abdo123/layout/shop_app/shop_layout.dart';
import 'package:abdo123/modules/shop_app/login/cubit/cubit.dart';
import 'package:abdo123/modules/shop_app/login/cubit/states.dart';
import 'package:abdo123/modules/shop_app/register/shop_register_screen.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:abdo123/shared/components/constants.dart';
import 'package:abdo123/shared/network/local/cache_helper.dart';
import 'package:abdo123/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel?.status == true) {
              // print(state.loginModel?.data?.token);
              // print(state.loginModel?.message);
              // showToast(
              //     txet: state.loginModel?.message?.toString() ??
              //         "No message available",
              //     state: ToastStates.SUCCESS);

              CacheHelper.saveData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                token = state.loginModel!.data!.token!;
                navigateAndFinish(context, const ShopLayout());
              });

              // Fluttertoast.showToast(
              //   msg: state.loginModel?.message?.toString() ??
              //       "No message available",
              //   toastLength: Toast.LENGTH_LONG,
              //   gravity: ToastGravity.BOTTOM,
              //   timeInSecForIosWeb: 5,
              //   backgroundColor: Colors.green,
              //   textColor: Colors.white,
              //   fontSize: 16.0,
              // );
            } else {
              // print(state.loginModel?.message);
              showToast(
                  txet: state.loginModel?.message?.toString() ??
                      "No message available",
                  state: ToastStates.ERROR);

              // Fluttertoast.showToast(
              //   msg: state.loginModel?.message?.toString() ??
              //       "No message available",
              //   toastLength: Toast.LENGTH_LONG,
              //   gravity: ToastGravity.BOTTOM,
              //   timeInSecForIosWeb: 5,
              //   backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //   fontSize: 16.0,
              // );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFromField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                              return null;
                            },
                            label: 'EmailAddress',
                            prefix: Icons.email),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFromField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short or empty';
                            }
                            return null;
                          },
                          label: 'Password',
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          prefix: Icons.lock,
                          isPassword: cubit.isPasswordShow,
                          suffix: cubit.suffix,
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login',
                              isUpperCase: true),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                            color: defaultColor,
                          )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            defaultTextButton(
                              text: 'Register Now',
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                              size: 16,
                              function: () {
                                navigateTo(context, const ShopRegisterScreen());
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
