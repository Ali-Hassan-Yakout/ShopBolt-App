import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../../product_screen/screen/product_screen.dart';
import '../manager/search_screen_cubit.dart';
import '../manager/search_screen_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final cubit = SearchScreenCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S().search,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 12.sp, left: 12.sp, right: 12.sp),
          child: Column(
            children: [
              TextFormField(
                controller: cubit.searchController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.orange),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.searchProducts(cubit.searchController.text);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.search, color: Colors.orange),
                  ),
                  label: Text(
                    S().search,
                    style: const TextStyle(color: Colors.orange),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              BlocBuilder<SearchScreenCubit, SearchScreenState>(
                buildWhen: (previous, current) => current is SearchProducts,
                builder: (context, state) => cubit.loading
                    ? SizedBox(
                        width: 70.sp,
                        height: 70.sp,
                        child: Lottie.asset(
                          'assets/animations/shopping_loader.json',
                        ),
                      )
                    : Expanded(child: searchItemsBuilder()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchItemsBuilder() {
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
                    ProductScreen(id: cubit.products[index].id),
              ),
            );
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
                  cubit.products[index].image,
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
                        cubit.products[index].name,
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
                            "${cubit.products[index].price}",
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
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
