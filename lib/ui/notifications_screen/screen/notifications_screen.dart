import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../manager/notifications_screen_cubit.dart';
import '../manager/notifications_screen_state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final cubit = NotificationsScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
          ),
          title: Text(
            S().notifications,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<NotificationsScreenCubit, NotificationsScreenState>(
          buildWhen: (previous, current) => current is GetNotifications,
          builder: (context, state) => cubit.loading
              ? Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                )
              : notificationItemBuilder(),
        ),
      ),
    );
  }

  Widget notificationItemBuilder() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cubit.notifications.length,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15.sp),
          margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 242, 219, 0.8),
            borderRadius: BorderRadius.circular(16.sp),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cubit.notifications[index].title,
                style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                cubit.notifications[index].message,
                style: TextStyle(fontSize: 18.sp),
              ),
            ],
          ),
        );
      },
    );
  }
}
