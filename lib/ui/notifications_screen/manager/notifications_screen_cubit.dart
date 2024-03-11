import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/models/app_endpoints.dart';
import 'package:shopbolt/models/notification_response.dart';
import 'package:shopbolt/ui/notifications_screen/manager/notifications_screen_state.dart';
import 'package:shopbolt/utils/app_dio.dart';

class NotificationsScreenCubit extends Cubit<NotificationsScreenState> {
  NotificationsScreenCubit() : super(NotificationsScreenInitial());
  List<DataListNotification> notifications = [];
  bool loading = true;

  Future<void> getNotifications() async {
    final response = await AppDio.get(endPoint: EndPoints.notifications);
    final notificationResponse = NotificationResponse.fromJson(response.data);
      notifications = notificationResponse.data.data;
      loading = false;
      emit(GetNotifications());
  }
}
