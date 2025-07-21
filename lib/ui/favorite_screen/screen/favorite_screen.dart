import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../../product_screen/screen/product_screen.dart';
import '../manager/favorite_screen_cubit.dart';
import '../manager/favorite_screen_state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final cubit = FavoriteScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getFavorite();
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
            S().favorite,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<FavoriteScreenCubit, FavoriteScreenState>(
          buildWhen: (previous, current) => current is GetFavorite,
          builder: (context, state) => cubit.loading
              ? Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                )
              : savedItemsBuilder(),
        ),
      ),
    );
  }

  Widget savedItemsBuilder() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cubit.products.length,
      itemBuilder: (context, index) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductScreen(id: cubit.products[index].product.id),
              ),
            ).then((value) {
              cubit.getFavorite();
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.sp),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.network(
                  cubit.products[index].product.image,
                  width: 35.sp,
                  height: 35.sp,
                ),
                SizedBox(width: 15.sp),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cubit.products[index].product.name,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 17.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10.sp),
                      Row(
                        children: [
                          Text(
                            "${cubit.products[index].product.price}",
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10.sp),
                          Visibility(
                            visible: cubit.products[index].product.discount > 0
                                ? true
                                : false,
                            child: Row(
                              children: [
                                Text(
                                  "${cubit.products[index].product.oldPrice}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.sp,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: 10.sp),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.sp,
                                    vertical: 10.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      253,
                                      151,
                                      1,
                                      0.6,
                                    ),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Text(
                                    "${cubit.products[index].product.discount}%",
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
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.iconsToggle[index].toggle =
                        !cubit.iconsToggle[index].toggle;
                    cubit.setFavourite(index);
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
                        cubit.iconsToggle[index].toggle
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.orange,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
