import 'package:abdo123/layout/shop_app/cubit.dart';
import 'package:abdo123/layout/shop_app/states.dart';
import 'package:abdo123/models/shop_app/categories_model.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateogiresScreen extends StatelessWidget {
  const CateogiresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopLayoutCubit.get(context)
                    .categoriesModel!
                    .data!
                    .data![index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopLayoutCubit.get(context)
                .categoriesModel!
                .data!
                .data!
                .length);
      },
    );
  }
}

Widget buildCatItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              model.image!,
            ),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            model.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
