import 'package:abdo123/layout/shop_app/cubit.dart';
import 'package:abdo123/layout/shop_app/states.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:abdo123/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLayoutLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                  ShopLayoutCubit.get(context)
                      .favoritesModel!
                      .data!
                      .data![index]
                      .product!,
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopLayoutCubit.get(context)
                  .favoritesModel!
                  .data!
                  .data!
                  .length),
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            );
          },
        );
      },
    );
  }
}
