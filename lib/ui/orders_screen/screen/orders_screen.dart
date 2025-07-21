import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../order_details_screen/screen/order_details_screen.dart';
import '../manager/orders_screen_cubit.dart';
import '../manager/orders_screen_state.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final cubit = OrdersScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getOrders();
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
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
          ),
          title: Text(
            S().orders,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<OrdersScreenCubit, OrdersScreenState>(
          buildWhen: (previous, current) => current is GetOrders,
          builder: (context, state) => cubit.loading
              ? Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                )
              : ordersItemBuilder(),
        ),
      ),
    );
  }

  Widget ordersItemBuilder() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cubit.orders.length,
      itemBuilder: (context, index) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OrderDetailsScreen(id: cubit.orders[index].id),
              ),
            ).then((value) => cubit.getOrders());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 242, 219, 0.8),
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  cubit.orders[index].date,
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  cubit.orders[index].total.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18.sp),
                ),
                Text(
                  cubit.orders[index].status,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
