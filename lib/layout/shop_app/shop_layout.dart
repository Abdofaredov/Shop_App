// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:abdo123/layout/shop_app/cubit.dart';
import 'package:abdo123/layout/shop_app/states.dart';
import 'package:abdo123/modules/shop_app/search/search_screen.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var layoutCubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, ShopSearchScreen());
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: layoutCubit.bottomScreens[layoutCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              layoutCubit.changeBottom(index);
            },
            currentIndex: layoutCubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
