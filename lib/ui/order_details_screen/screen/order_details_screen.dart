import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../order_action_screen/screen/order_action_screen.dart';
import '../manager/order_details_screen_cubit.dart';
import '../manager/order_details_screen_state.dart';

class OrderDetailsScreen extends StatefulWidget {
  final num id;

  const OrderDetailsScreen({super.key, required this.id});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final cubit = OrderDetailsScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getOrderDetails(widget.id);
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
            S().orderDetails,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<OrderDetailsScreenCubit, OrderDetailsScreenState>(
          builder: (context, state) => cubit.loading
              ? Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                )
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.only(bottom: 20.sp),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 242, 219, 0.8),
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S().deliverTo,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.sp),
                                    Text(
                                      cubit.deliverTo,
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                    SizedBox(height: 5.sp),
                                    Text(
                                      S().notes,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.sp),
                                    Text(
                                      cubit.address.notes,
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          cubit.orderCanceled
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 45.sp,
                                  padding: EdgeInsets.all(15.sp),
                                  margin: EdgeInsets.only(bottom: 20.sp),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      255,
                                      242,
                                      219,
                                      0.8,
                                    ),
                                    borderRadius: BorderRadius.circular(16.sp),
                                  ),
                                  child: Text(
                                    S().orderCancelled,
                                    style: TextStyle(
                                      fontSize: 19.sp,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 85.sp,
                                  padding: EdgeInsets.all(25.sp),
                                  margin: EdgeInsets.only(bottom: 20.sp),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      255,
                                      242,
                                      219,
                                      0.8,
                                    ),
                                    borderRadius: BorderRadius.circular(16.sp),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 19.sp,
                                                color: Colors.orange,
                                              ),
                                              SizedBox(
                                                height: 30.sp,
                                                child: const VerticalDivider(
                                                  color: Colors.orange,
                                                  thickness: 2,
                                                ),
                                              ),
                                              Icon(
                                                Icons.circle,
                                                size: 19.sp,
                                                color: Colors.black12,
                                              ),
                                              SizedBox(
                                                height: 30.sp,
                                                child: const VerticalDivider(
                                                  color: Colors.black12,
                                                  thickness: 2,
                                                ),
                                              ),
                                              Icon(
                                                Icons.circle,
                                                size: 19.sp,
                                                color: Colors.black12,
                                              ),
                                              SizedBox(
                                                height: 30.sp,
                                                child: const VerticalDivider(
                                                  color: Colors.black12,
                                                  thickness: 2,
                                                ),
                                              ),
                                              Icon(
                                                Icons.circle,
                                                size: 19.sp,
                                                color: Colors.black12,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 20.sp),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S().orderPlaced,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 30.sp),
                                              Text(
                                                S().shipped,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 30.sp),
                                              Text(
                                                S().outOfDelivery,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 29.sp),
                                              Text(
                                                S().delivered,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        height: 28.sp,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            cubit.cancelOrder(widget.id);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderActionScreen(
                                                      action:
                                                          S().orderCancelled,
                                                    ),
                                              ),
                                            ).then(
                                              (value) => cubit.getOrderDetails(
                                                widget.id,
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.sp),
                                            ),
                                          ),
                                          child: Text(
                                            S().cancelOrder,
                                            style: TextStyle(
                                              fontSize: 19.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 15.sp),
                            margin: EdgeInsets.only(bottom: 20.sp),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 242, 219, 0.8),
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S().orderDetails,
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15.sp),
                                Container(
                                  padding: EdgeInsets.all(15.sp),
                                  color: const Color.fromRGBO(
                                    255,
                                    214,
                                    164,
                                    1.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        S().date,
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                      const Spacer(),
                                      Text(
                                        cubit.data.date,
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.sp),
                                  color: const Color.fromRGBO(
                                    255,
                                    198,
                                    99,
                                    1.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        S().price,
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                      const Spacer(),
                                      Text(
                                        cubit.data.cost.toString(),
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.sp),
                                  color: const Color.fromRGBO(
                                    255,
                                    214,
                                    164,
                                    1.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        S().vat,
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '14%',
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.sp),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      255,
                                      198,
                                      99,
                                      1.0,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16.sp),
                                      bottomRight: Radius.circular(16.sp),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        S().totalPrice,
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                      const Spacer(),
                                      Text(
                                        (cubit.data.cost +
                                                cubit.data.cost * 0.14)
                                            .toStringAsFixed(2),
                                        style: TextStyle(fontSize: 17.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                S().products,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(width: 15.sp),
                              Text(
                                "(${cubit.data.products.length})",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.sp),
                          productsItemBuilder(),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget productsItemBuilder() {
    return SizedBox(
      height: 60.sp,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: cubit.data.products.length,
        itemBuilder: (context, index) {
          return Container(
            width: 65.sp,
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsets.only(right: 20.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Column(
              children: [
                Image.network(cubit.data.products[index].image, height: 40.sp),
                Text(
                  cubit.data.products[index].name,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Text(
                  '${cubit.data.products[index].price} ${S().egp}',
                  style: TextStyle(fontSize: 17.sp),
                ),
                Text(
                  '${S().quantity}: ${cubit.data.products[index].quantity}',
                  style: TextStyle(fontSize: 17.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
