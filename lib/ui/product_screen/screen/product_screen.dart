import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../../cart_screen/screen/cart_screen.dart';
import '../manager/product_screen_cubit.dart';
import '../manager/product_screen_state.dart';

class ProductScreen extends StatefulWidget {
  final num id;

  const ProductScreen({super.key, required this.id});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final cubit = ProductScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getProductDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<ProductScreenCubit, ProductScreenState>(
        buildWhen: (previous, current) => current is GetProductDetails,
        builder: (context, state) => cubit.loading
            ? Scaffold(
                body: Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context, cubit.iconToggle);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 22.sp,
                      color: Colors.orange,
                    ),
                  ),
                  title: Text(
                    cubit.product.name,
                    style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        ).then((value) => cubit.getProductDetails(widget.id));
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        size: 22.sp,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    productItemBuilder(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.sp,
                        vertical: 16.sp,
                      ),
                      child: SizedBox(
                        height: 30.sp,
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.setItemToCart(widget.id);
                            cubit.inCart = !cubit.inCart;
                            cubit.onInCartChange();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                          ),
                          child:
                              BlocBuilder<
                                ProductScreenCubit,
                                ProductScreenState
                              >(
                                buildWhen: (previous, current) =>
                                    current is InCartChange,
                                builder: (context, state) => Text(
                                  cubit.inCart
                                      ? S().removeFromCart
                                      : S().addToCart,
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget productItemBuilder() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 242, 219, 0.8),
                borderRadius: BorderRadius.circular(18.sp),
              ),
              child: Image.network(
                cubit.product.image,
                fit: BoxFit.contain,
                height: 70.sp,
              ),
            ),
            SizedBox(height: 15.sp),
            Row(
              children: [
                Expanded(
                  child: Text(
                    cubit.product.name,
                    style: TextStyle(
                      fontSize: 19.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.iconToggle = !cubit.iconToggle;
                    cubit.setFavourite(widget.id);
                    BlocProvider.of<AppManagerCubit>(
                      context,
                    ).onFavoriteChange();
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: BlocBuilder<AppManagerCubit, AppManagerState>(
                    buildWhen: (previous, current) => current is FavoriteChange,
                    builder: (context, state) {
                      return Icon(
                        cubit.iconToggle
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.orange,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            Row(
              children: [
                Text(
                  "${cubit.product.price} ${S().egp}",
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: cubit.product.discount > 0 ? true : false,
                  child: Row(
                    children: [
                      Text(
                        "${cubit.product.oldPrice} ${S().egp}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.sp,
                          vertical: 12.sp,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(253, 151, 1, 0.6),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        child: Text(
                          "${cubit.product.discount}%",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S().description,
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.sp),
                Text(
                  cubit.product.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
