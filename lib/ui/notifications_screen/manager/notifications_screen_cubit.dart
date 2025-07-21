import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/app_endpoints.dart';
import '../../../models/notification_response.dart';
import '../../../utils/app_dio.dart';
import 'notifications_screen_state.dart';

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
