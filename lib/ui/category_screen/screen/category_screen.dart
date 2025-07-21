import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../../cart_screen/screen/cart_screen.dart';
import '../../product_screen/screen/product_screen.dart';
import '../manager/category_screen_cubit.dart';
import '../manager/category_screen_state.dart';

class CategoryScreen extends StatefulWidget {
  final num id;

  final String name;

  const CategoryScreen({super.key, required this.id, required this.name});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final cubit = CategoryScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getCategoryDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, cubit.iconsToggle);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.orange),
          ),
          title: Text(
            widget.name,
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
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
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
        body: BlocBuilder<CategoryScreenCubit, CategoryScreenState>(
          buildWhen: (previous, current) => current is GetCategoriesDetails,
          builder: (context, state) => cubit.loading
              ? Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    top: 10.sp,
                    right: 12.sp,
                    left: 12.sp,
                  ),
                  child: productItemBuilder(),
                ),
        ),
      ),
    );
  }

  Widget productItemBuilder() {
    return BlocBuilder<AppManagerCubit, AppManagerState>(
      buildWhen: (previous, current) => current is FavoriteChange,
      builder: (context, state) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.products.length,
          itemBuilder: (context, index) {
            return index * 2 < cubit.products.length
                ? Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                  id: cubit
                                      .products[index + 1 ==
                                                  cubit.products.length &&
                                              cubit.products.length % 2 != 0
                                          ? index
                                          : index - 1]
                                      .id,
                                ),
                              ),
                            ).then((value) {
                              cubit.iconsToggle[index - 1].toggle = value;
                              BlocProvider.of<AppManagerCubit>(
                                context,
                              ).onFavoriteChange();
                            });
                          },
                          child: Container(
                            height: 70.sp,
                            padding: EdgeInsets.all(15.sp),
                            margin: EdgeInsets.only(bottom: 10.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    cubit.products[index = index * 2].image,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Text(
                                  cubit.products[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${cubit.products[index].price.toString()} ${S().egp}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        if (index + 1 ==
                                                cubit.products.length &&
                                            cubit.products.length % 2 != 0) {
                                          cubit.iconsToggle[index].toggle =
                                              !cubit.iconsToggle[index].toggle;
                                          cubit.setFavourite(index);
                                        } else {
                                          cubit.iconsToggle[index - 1].toggle =
                                              !cubit
                                                  .iconsToggle[index - 1]
                                                  .toggle;
                                          cubit.setFavourite(index - 1);
                                        }
                                        BlocProvider.of<AppManagerCubit>(
                                          context,
                                        ).onFavoriteChange();
                                      },
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      icon: Icon(
                                        cubit.iconsToggle[index].toggle
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: cubit.products[index].discount > 0
                                      ? true
                                      : false,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${cubit.products[index].oldPrice} ${S().egp}",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16.sp,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.sp,
                                          vertical: 12.sp,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                            253,
                                            151,
                                            1,
                                            0.6,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.sp,
                                          ),
                                        ),
                                        child: Text(
                                          "${cubit.products[index].discount}%",
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
                          ),
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      Expanded(
                        child: index + 1 == cubit.products.length
                            ? const SizedBox()
                            : InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductScreen(
                                        id: cubit.products[index].id,
                                      ),
                                    ),
                                  ).then((value) {
                                    cubit.iconsToggle[index].toggle = value;
                                    BlocProvider.of<AppManagerCubit>(
                                      context,
                                    ).onFavoriteChange();
                                  });
                                },
                                child: Container(
                                  height: 70.sp,
                                  padding: EdgeInsets.all(15.sp),
                                  margin: EdgeInsets.only(bottom: 10.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(16.sp),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          cubit.products[++index].image,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                      Text(
                                        cubit.products[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${cubit.products[index].price.toString()} ${S().egp}",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              cubit.iconsToggle[index].toggle =
                                                  !cubit
                                                      .iconsToggle[index]
                                                      .toggle;
                                              cubit.setFavourite(index);
                                              BlocProvider.of<AppManagerCubit>(
                                                context,
                                              ).onFavoriteChange();
                                            },
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            icon: Icon(
                                              cubit.iconsToggle[index].toggle
                                                  ? Icons.favorite
                                                  : Icons
                                                        .favorite_border_outlined,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible:
                                            cubit.products[index].discount > 0
                                            ? true
                                            : false,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${cubit.products[index].oldPrice} ${S().egp}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16.sp,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 12.sp,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                  253,
                                                  151,
                                                  1,
                                                  0.6,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                              ),
                                              child: Text(
                                                "${cubit.products[index].discount}%",
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
                                ),
                              ),
                      ),
                    ],
                  )
                : const SizedBox();
          },
        );
      },
    );
  }
}
