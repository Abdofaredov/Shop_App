import 'package:abdo123/layout/shop_app/cubit.dart';
import 'package:abdo123/layout/shop_app/states.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:abdo123/shared/components/constants.dart';
import 'package:abdo123/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopLayoutCubit.get(context);

    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).userModel;

        if (model != null) {
          cubit.nameController.text = model.data?.name ?? '';
          cubit.emailController.text = model.data?.email ?? '';
          cubit.phoneController.text = model.data?.phone ?? '';
        }
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.formKeySettings,
              child: Column(
                children: [
                  if (state is ShopLayoutLoadingUpDateUserState)
                    const LinearProgressIndicator(
                        backgroundColor: defaultColor),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFromField(
                    controller: cubit.nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFromField(
                    controller: cubit.emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFromField(
                    controller: cubit.phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'Logout'),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if (cubit.formKeySettings.currentState!.validate()) {
                          ShopLayoutCubit.get(context).upDateUserData(
                              name: cubit.nameController.text,
                              email: cubit.emailController.text,
                              phone: cubit.phoneController.text);
                        }
                      },
                      text: 'Update '),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
              child: CircularProgressIndicator(backgroundColor: defaultColor)),
        );
      },
    );
  }
}
