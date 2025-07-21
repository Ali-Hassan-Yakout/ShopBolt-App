import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../../cart_screen/screen/cart_screen.dart';
import '../../category_screen/screen/category_screen.dart';
import '../../notifications_screen/screen/notifications_screen.dart';
import '../../product_screen/screen/product_screen.dart';
import '../manager/home_screen_cubit.dart';
import '../manager/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = HomeScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        buildWhen: (previous, current) => current is GetHome,
        builder: (context, state) => cubit.loading
            ? Scaffold(
                body: Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${S().welcome}, ",
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: cubit.userName[0],
                              style: TextStyle(fontSize: 19.sp),
                            ),
                          ],
                        ),
                      ),
                      Text(S().whatWould, style: TextStyle(fontSize: 17.sp)),
                    ],
                  ),
                  actions: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationsScreen(),
                              ),
                            );
                          },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.notifications_active_outlined,
                            size: 22.sp,
                          ),
                        ),
                        Positioned(
                          bottom: 15.sp,
                          right: 2.sp,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.sp,
                              horizontal: 8.sp,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: Text(
                              "${cubit.totalNotifications}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        );
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.shopping_cart_outlined, size: 22.sp),
                    ),
                  ],
                ),
                body: Padding(
                  padding: EdgeInsets.only(
                    top: 10.sp,
                    right: 12.sp,
                    left: 12.sp,
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      categoryItemBuilder(),
                      bannerItemBuilder(),
                      productItemBuilder(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget categoryItemBuilder() {
    return SizedBox(
      height: 38.sp,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cubit.categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    id: cubit.categories[index].id,
                    name: cubit.categories[index].name,
                  ),
                ),
              ).then((value) {
                for (int i = 0; i < cubit.iconsToggle.length; i++) {
                  for (int j = 0; j < value.length; j++) {
                    if (cubit.iconsToggle[i].id == value[j].id) {
                      cubit.iconsToggle[i].toggle = value[j].toggle;
                    }
                  }
                }
                BlocProvider.of<AppManagerCubit>(context).onFavoriteChange();
              });
            },
            child: Container(
              width: 50.sp,
              margin: EdgeInsets.only(right: 10.sp),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                color: Colors.white,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: Image.network(
                      cubit.categories[index].image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: const Color.fromRGBO(126, 126, 127, 0.5),
                    ),
                  ),
                  Text(
                    cubit.categories[index].name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bannerItemBuilder() {
    return Container(
      height: 65.sp,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Visibility(
        visible: cubit.banners.isEmpty ? false : true,
        child: CarouselSlider(
          items: cubit.banners.map((e) {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: CachedNetworkImage(imageUrl: e.image, fit: BoxFit.cover),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            autoPlayCurve: Curves.easeOut,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 5),
            viewportFraction: 1,
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
          shrinkWrap: true,
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
                            padding: EdgeInsets.all(10.sp),
                            margin: EdgeInsets.only(bottom: 10.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        18.sp,
                                      ),
                                    ),
                                    child: Image.network(
                                      cubit.products[index = index * 2].image,
                                      fit: BoxFit.fitWidth,
                                    ),
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
                                  padding: EdgeInsets.all(10.sp),
                                  margin: EdgeInsets.only(bottom: 10.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(16.sp),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              18.sp,
                                            ),
                                          ),
                                          child: Image.network(
                                            cubit.products[++index].image,
                                            fit: BoxFit.fitWidth,
                                          ),
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
