import 'package:abdo123/modules/shop_app/search/cubit.dart';
import 'package:abdo123/modules/shop_app/search/states.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:abdo123/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchScreen extends StatelessWidget {
  const ShopSearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = SearchCubit.get(context);

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: cubit.formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFromField(
                        controller: cubit.searchController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String? text) {
                          SearchCubit.get(context).search(text!);
                        },
                        label: 'Search',
                        prefix: Icons.search),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(
                        backgroundColor: defaultColor,
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccsessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data![index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
