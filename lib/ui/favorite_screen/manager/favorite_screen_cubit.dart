import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/app_endpoints.dart';
import '../../../models/favorite.dart';
import '../../../models/favorite_response.dart';
import '../../../utils/app_dio.dart';
import 'favorite_screen_state.dart';

class FavoriteScreenCubit extends Cubit<FavoriteScreenState> {
  FavoriteScreenCubit() : super(FavoriteScreenInitial());
  List<Favorite> iconsToggle = [];
  List<DataListFavorite> products = [];
  bool loading = true;

  Future<void> setFavourite(int index) async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': products[index].product.id},
    );
  }

  Future<void> getFavorite() async {
    final response = await AppDio.get(endPoint: EndPoints.favorites);
    final favoriteResponse = FavoriteResponse.fromJson(response.data);

    products = favoriteResponse.data.data;
    iconsToggle.clear();
    for (int i = 0; i < products.length; i++) {
      iconsToggle.add(
        Favorite(id: favoriteResponse.data.data[i].id, toggle: true),
      );
    }
    loading = false;
    emit(GetFavorite());
  }
}
