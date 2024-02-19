import 'package:abdo123/layout/shop_app/shop_layout.dart';
import 'package:abdo123/modules/shop_app/register/cubit/cubit.dart';
import 'package:abdo123/modules/shop_app/register/cubit/states.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:abdo123/shared/components/constants.dart';
import 'package:abdo123/shared/network/local/cache_helper.dart';
import 'package:abdo123/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopRegisterCubit.get(context);
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel?.status == true) {
              // print(state.loginModel?.data?.token);
              // print(state.loginModel?.message);

              CacheHelper.saveData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                token = state.loginModel!.data!.token!;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              // print(state.loginModel?.message);
              showToast(
                  txet: state.loginModel?.message?.toString() ??
                      "No message available",
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFromField(
                            controller: cubit.nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your name';
                              }
                              return null;
                            },
                            label: 'User Name',
                            prefix: Icons.person),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFromField(
                            controller: cubit.emailController,
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
                          controller: cubit.passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short or empty';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock,
                          isPassword:
                              ShopRegisterCubit.get(context).isPasswordShow,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFromField(
                            controller: cubit.phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      name: cubit.nameController.text,
                                      phone: cubit.phoneController.text,
                                      email: cubit.emailController.text,
                                      password: cubit.passwordController.text);
                                }
                              },
                              text: 'Register',
                              isUpperCase: true),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator(
                            color: defaultColor,
                          )),
                        ),
                        const SizedBox(
                          height: 30,
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
