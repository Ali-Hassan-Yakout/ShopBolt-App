import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bolt/ui/product_screen/manager/product_screen_state.dart';

import '../../../models/app_endpoints.dart';
import '../../../models/product_response.dart';
import '../../../utils/app_dio.dart';

class ProductScreenCubit extends Cubit<ProductScreenState> {
  ProductScreenCubit() : super(ProductScreenInitial());
  DataProduct product = DataProduct();
  bool iconToggle = false;
  bool inCart = false;
  bool loading = true;

  Future<void> setFavourite(num id) async {
    await AppDio.post(endPoint: EndPoints.favorites, body: {'product_id': id});
  }

  Future<void> setItemToCart(num id) async {
    await AppDio.post(endPoint: EndPoints.carts, body: {"product_id": id});
  }

  Future<void> getProductDetails(num id) async {
    loading = true;
    emit(GetProductDetails());
    final response = await AppDio.get(endPoint: '${EndPoints.product}/$id');
    final productResponse = ProductResponse.fromJson(response.data);

    product = productResponse.data;
    inCart = product.inCart;
    iconToggle = product.inFavorites;
    loading = false;
    emit(GetProductDetails());
  }

  void onInCartChange() => emit(InCartChange());
}
