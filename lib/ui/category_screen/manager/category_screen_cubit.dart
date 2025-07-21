import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/app_endpoints.dart';
import '../../../models/category_details_response.dart';
import '../../../models/favorite.dart';
import '../../../utils/app_dio.dart';
import 'category_screen_state.dart';

class CategoryScreenCubit extends Cubit<CategoryScreenState> {
  CategoryScreenCubit() : super(CategoryScreenInitial());
  bool loading = true;
  List<DataListCategoryDetails> products = [];
  List<Favorite> iconsToggle = [];

  Future<void> getCategoryDetails(num id) async {
    final response = await AppDio.get(endPoint: '${EndPoints.categories}/$id');
    final categoryDetailsResponse = CategoryDetailsResponse.fromJson(
      response.data,
    );
    products = categoryDetailsResponse.data.data;
    for (int i = 0; i < products.length; i++) {
      iconsToggle.add(
        Favorite(
          id: categoryDetailsResponse.data.data[i].id,
          toggle: categoryDetailsResponse.data.data[i].inFavorites,
        ),
      );
    }
    loading = false;
    emit(GetCategoriesDetails());
  }

  Future<void> setFavourite(int index) async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': products[index].id},
    );
  }
}
