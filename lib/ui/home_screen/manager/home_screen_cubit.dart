import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/models/app_endpoints.dart';
import 'package:shopbolt/models/category_response.dart';
import 'package:shopbolt/models/favorite.dart';
import 'package:shopbolt/models/home_response.dart';
import 'package:shopbolt/models/notification_response.dart';
import 'package:shopbolt/models/profile_response.dart';
import 'package:shopbolt/ui/home_screen/manager/home_screen_state.dart';
import 'package:shopbolt/utils/app_dio.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());
  List<String> userName = [];
  num totalNotifications = 0;
  Banners banner = Banners();
  List<DataListCategory> categories = [];
  List<Banners> banners = [];
  List<Products> products = [];
  List<Favorite> iconsToggle = [];
  bool loading = true;

  Future<void> getHome() async {
    getTotalNotifications();
    getCategories();
    getProfile();
    final response = await AppDio.get(endPoint: EndPoints.home);
    final homeResponse = HomeResponse.fromJson(response.data);

    banners = homeResponse.data.banners;
    products = homeResponse.data.products;
    for (int i = 0; i < products.length; i++) {
      iconsToggle.add(
        Favorite(
          id: homeResponse.data.products[i].id,
          toggle: homeResponse.data.products[i].inFavorites,
        ),
      );
    }
    banner = banners[Random().nextInt(banners.length)];
    loading = false;
    emit(GetHome());
  }

  Future<void> setFavourite(int index) async {
    await AppDio.post(
      endPoint: EndPoints.favorites,
      body: {'product_id': products[index].id},
    );
  }

  Future<void> getTotalNotifications() async {
    final response = await AppDio.get(endPoint: EndPoints.notifications);
    final notificationResponse = NotificationResponse.fromJson(response.data);
    totalNotifications = notificationResponse.data.total;
  }

  Future<void> getProfile() async {
    final response = await AppDio.get(endPoint: EndPoints.profile);
    final profileResponse = ProfileResponse.fromJson(response.data);
    userName = profileResponse.data.name.split(' ');
  }

  Future<void> getCategories() async {
    final response = await AppDio.get(endPoint: EndPoints.categories);
    final categoryResponse = CategoryResponse.fromJson(response.data);
    categories = categoryResponse.data.data;
  }
}
