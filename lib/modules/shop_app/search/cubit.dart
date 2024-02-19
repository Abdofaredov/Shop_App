import 'package:abdo123/models/shop_app/search_model.dart';
import 'package:abdo123/modules/shop_app/search/states.dart';
import 'package:abdo123/shared/components/constants.dart';
import 'package:abdo123/shared/network/end_points.dart';
import 'package:abdo123/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  SearchModel? model;
  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccsessState());
    }).catchError((error) {
      // print(error.toString());
      emit(SearchErrorState());
    });
  }
}
