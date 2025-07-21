import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bolt/ui/search_screen/manager/search_screen_state.dart';

import '../../../models/app_endpoints.dart';
import '../../../models/favorite.dart';
import '../../../models/search_response.dart';
import '../../../utils/app_dio.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  SearchScreenCubit() : super(SearchScreenInitial());
  final searchController = TextEditingController();
  List<Favorite> iconsToggle = [];
  List<DataListSearch> products = [];
  bool loading = false;

  Future<void> setFavourite(int index) async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': products[index].id},
    );
  }

  Future<void> searchProducts(String value) async {
    loading = true;
    emit(SearchProducts());
    products.clear();
    iconsToggle.clear();
    final response = await AppDio.post(
      endPoint: EndPoints.search,
      body: {'text': value},
    );
    final searchResponse = SearchResponse.fromJson(response.data);

    products = searchResponse.data.data;
    for (int i = 0; i < products.length; i++) {
      iconsToggle.add(
        Favorite(id: products[i].id, toggle: products[i].inFavorites),
      );
    }
    loading = false;
    emit(SearchProducts());
  }
}
