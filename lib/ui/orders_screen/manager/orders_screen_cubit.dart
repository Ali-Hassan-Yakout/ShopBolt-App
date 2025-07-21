import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/app_endpoints.dart';
import '../../../models/order_response.dart';
import '../../../utils/app_dio.dart';
import 'orders_screen_state.dart';

class OrdersScreenCubit extends Cubit<OrdersScreenState> {
  OrdersScreenCubit() : super(OrdersScreenInitial());
  List<DataListOrder> orders = [];
  bool loading = true;

  Future<void> getOrders() async {
    final response = await AppDio.get(endPoint: EndPoints.orders);
    final orderResponse = OrderResponse.fromJson(response.data);
    orders = orderResponse.data.data;
    loading = false;
    emit(GetOrders());
  }
}
