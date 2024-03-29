import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/models/app_endpoints.dart';
import 'package:shopbolt/models/order_response.dart';
import 'package:shopbolt/ui/orders_screen/manager/orders_screen_state.dart';
import 'package:shopbolt/utils/app_dio.dart';

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
