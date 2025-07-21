import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/address_response.dart';
import '../../../models/app_endpoints.dart';
import '../../../models/cart_response.dart';
import '../../../utils/app_dio.dart';
import 'cart_screen_state.dart';

class CartScreenCubit extends Cubit<CartScreenState> {
  CartScreenCubit() : super(CartScreenInitial());
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final regionController = TextEditingController();
  final detailsController = TextEditingController();
  final noteController = TextEditingController();
  bool newAddress = true;
  String deliverTo = '';
  num subTotal = 0;
  DataListAddress address = DataListAddress();
  List<CartItems> products = [];
  List<num> quantity = [];
  bool loading = true;

  Future<void> getCart() async {
    final response = await AppDio.get(endPoint: EndPoints.carts);
    final cartResponse = CartResponse.fromJson(response.data);
    products = cartResponse.data.cartItems;
    subTotal = cartResponse.data.subTotal;
    quantity.clear();
    for (int i = 0; i < products.length; i++) {
      quantity.add(products[i].quantity);
    }
    loading = false;
    emit(GetCart());
  }

  Future<void> deleteItemFromCart(int index) async {
    await AppDio.delete(endPoint: '${EndPoints.carts}/${products[index].id}');
    products.removeAt(index);
    quantity.removeAt(index);
    emit(DeleteItemFromCart());
  }

  Future<void> updateCart(int index) async {
    await AppDio.put(
      endPoint: '${EndPoints.carts}/${products[index].id}',
      body: {'quantity': quantity[index]},
    );
  }

  Future<void> getAddress() async {
    final response = await AppDio.get(endPoint: EndPoints.addresses);
    final addressResponse = AddressResponse.fromJson(response.data);

    if (addressResponse.data.total == 0) {
      newAddress = true;
    } else {
      address = addressResponse.data.data[0];
      deliverTo =
          '${address.name} - ${address.city} - ${address.region} - ${address.details}';
      newAddress = false;
    }
    emit(GetAddress());
  }

  Future<void> updateAddress() async {
    await AppDio.put(
      endPoint: '${EndPoints.addresses}/${address.id}',
      body: {
        "name": nameController.text,
        "city": cityController.text,
        "region": regionController.text,
        "details": detailsController.text,
        "latitude": 0,
        "longitude": 0,
        "notes": noteController.text,
      },
    );
  }

  Future<void> addAddress() async {
    await AppDio.post(
      endPoint: EndPoints.addresses,
      body: {
        "name": nameController.text,
        "city": cityController.text,
        "region": regionController.text,
        "details": detailsController.text,
        "notes": noteController.text,
        "latitude": 0,
        "longitude": 0,
      },
    );
  }

  Future<void> addOrder() async {
    await AppDio.post(
      endPoint: EndPoints.orders,
      body: {
        'address_id': address.id,
        'payment_method': 1,
        'use_points': false,
      },
    );
  }

  void onChangeItems() {
    emit(ChangeItems());
  }
}
