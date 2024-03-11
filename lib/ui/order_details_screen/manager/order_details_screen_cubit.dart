import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/generated/l10n.dart';
import 'package:shopbolt/models/app_endpoints.dart';
import 'package:shopbolt/models/order_details_response.dart';
import 'package:shopbolt/ui/order_details_screen/manager/order_details_screen_state.dart';
import 'package:shopbolt/utils/app_dio.dart';

class OrderDetailsScreenCubit extends Cubit<OrderDetailsScreenState> {
  OrderDetailsScreenCubit() : super(OrderDetailsScreenInitial());
  Address address = Address();
  Data data = Data();
  bool orderCanceled = false;
  String deliverTo = '';
  bool loading = true;

  Future<void> getOrderDetails(num id) async {
    final response = await AppDio.get(endPoint: '${EndPoints.orders}/$id');
    final orderDetailsResponse = OrderDetailsResponse.fromJson(response.data);
    address = orderDetailsResponse.data.address;
    deliverTo =
        '${address.name} - ${address.city} - ${address.region} - ${address.details}';
    data = orderDetailsResponse.data;
    orderCanceled = data.status == S().cancelled ? true : false;
    loading = false;
    emit(GetOrderDetails());
  }

  Future<void> cancelOrder(num id) async {
    AppDio.get(endPoint: '${EndPoints.orders}/$id/cancel');
  }
}
