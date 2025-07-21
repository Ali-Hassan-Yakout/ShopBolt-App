import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../order_action_screen/screen/order_action_screen.dart';
import '../manager/cart_screen_cubit.dart';
import '../manager/cart_screen_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cubit = CartScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getAddress();
    cubit.getCart();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.nameController.dispose();
    cubit.cityController.dispose();
    cubit.regionController.dispose();
    cubit.detailsController.dispose();
    cubit.noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
          ),
          title: Text(
            S().cart,
            style: TextStyle(
              fontSize: 19.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<CartScreenCubit, CartScreenState>(
          buildWhen: (previous, current) => current is GetCart,
          builder: (context, state) => cubit.loading
              ? Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: Column(
                          children: [
                            BlocBuilder<CartScreenCubit, CartScreenState>(
                              buildWhen: (previous, current) =>
                                  current is GetAddress,
                              builder: (context, state) => cubit.newAddress
                                  ? InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              alertDialog(title: 'Add Address'),
                                          barrierDismissible: true,
                                        );
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        height: 47.sp,
                                        padding: EdgeInsets.all(15.sp),
                                        margin: EdgeInsets.all(18.sp),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                            255,
                                            242,
                                            219,
                                            0.8,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16.sp,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Add Address',
                                              style: TextStyle(fontSize: 18.sp),
                                            ),
                                            Icon(
                                              Icons.add,
                                              size: 22.sp,
                                              color: Colors.orange,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => alertDialog(
                                            title: 'Edit Address',
                                          ),
                                          barrierDismissible: true,
                                        );
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        padding: EdgeInsets.all(15.sp),
                                        margin: EdgeInsets.all(18.sp),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                            255,
                                            242,
                                            219,
                                            0.8,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16.sp,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S().deliverTo,
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.sp),
                                                  Text(
                                                    cubit.deliverTo,
                                                    style: TextStyle(
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.sp),
                                                  Text(
                                                    S().notes,
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.sp),
                                                  Text(
                                                    cubit.address.notes,
                                                    style: TextStyle(
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.edit_outlined,
                                              size: 22.sp,
                                              color: Colors.orange,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(height: 20.sp),
                            Row(
                              children: [
                                SizedBox(width: 15.sp),
                                Text(
                                  S().products,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(width: 15.sp),
                                Text(
                                  "(${cubit.products.length})",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.sp),
                            inCartItemBuilder(),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<CartScreenCubit, CartScreenState>(
                      buildWhen: (previous, current) =>
                          current is ChangeItems ||
                          current is DeleteItemFromCart,
                      builder: (context, state) => Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15.sp),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  S().price,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${cubit.subTotal} ${S().egp}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15.sp),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  S().vat,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '14%',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15.sp),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  S().totalPrice,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${(cubit.subTotal + cubit.subTotal * 0.14).toStringAsFixed(2)} ${S().egp}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15.sp),
                      color: Colors.transparent,
                      child: SizedBox(
                        height: 30.sp,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!cubit.newAddress &&
                                cubit.products.isNotEmpty) {
                              cubit.addOrder();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderActionScreen(
                                    action: S().orderConfirmed,
                                  ),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.sp),
                            ),
                          ),
                          child: Text(
                            S().confirmOrder,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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

  Widget inCartItemBuilder() {
    return Expanded(
      child: BlocBuilder<CartScreenCubit, CartScreenState>(
        buildWhen: (previous, current) => current is DeleteItemFromCart,
        builder: (context, state) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.products.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15.sp),
                margin: EdgeInsets.symmetric(
                  vertical: 10.sp,
                  horizontal: 10.sp,
                ),
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
                      width: 32.sp,
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
                            style: TextStyle(fontSize: 17.sp),
                          ),
                          SizedBox(height: 10.sp),
                          Row(
                            children: [
                              Text(
                                "${cubit.products[index].product.price}",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.sp),
                              Visibility(
                                visible:
                                    cubit.products[index].product.discount > 0
                                    ? true
                                    : false,
                                child: Row(
                                  children: [
                                    Text(
                                      "${cubit.products[index].product.oldPrice}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.sp,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(width: 10.sp),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.sp,
                                        vertical: 10.sp,
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
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  cubit.deleteItemFromCart(index);
                                  cubit.subTotal =
                                      cubit.subTotal -
                                      cubit.products[index].product.price *
                                          cubit.quantity[index];
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 10.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(14.sp),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.sp),
                              InkWell(
                                onTap: () {
                                  cubit.quantity[index]++;
                                  cubit.updateCart(index);
                                  cubit.subTotal =
                                      cubit.subTotal +
                                      cubit.products[index].product.price;
                                  cubit.onChangeItems();
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 10.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      253,
                                      151,
                                      1,
                                      0.6,
                                    ),
                                    borderRadius: BorderRadius.circular(14.sp),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.sp),
                              BlocBuilder<CartScreenCubit, CartScreenState>(
                                buildWhen: (previous, current) =>
                                    current is ChangeItems,
                                builder: (context, state) =>
                                    Text('${cubit.quantity[index]}'),
                              ),
                              SizedBox(width: 10.sp),
                              InkWell(
                                onTap: () {
                                  cubit.quantity[index]--;
                                  cubit.updateCart(index);
                                  cubit.subTotal =
                                      cubit.subTotal -
                                      cubit.products[index].product.price;
                                  cubit.onChangeItems();
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.sp,
                                    vertical: 10.sp,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                      253,
                                      151,
                                      1,
                                      0.6,
                                    ),
                                    borderRadius: BorderRadius.circular(14.sp),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget alertDialog({required String title}) {
    cubit.nameController.text = cubit.address.name;
    cubit.cityController.text = cubit.address.city;
    cubit.regionController.text = cubit.address.region;
    cubit.detailsController.text = cubit.address.details;
    cubit.noteController.text = cubit.address.notes;
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.sp),
              TextFormField(
                controller: cubit.nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outlined, color: Colors.orange),
                  label: Text("Place", style: TextStyle(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              TextFormField(
                controller: cubit.cityController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter city!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_city, color: Colors.orange),
                  label: Text("City", style: TextStyle(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              TextFormField(
                controller: cubit.regionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter region!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.orange,
                  ),
                  label: Text("Region", style: TextStyle(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              TextFormField(
                controller: cubit.detailsController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter details!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.orange,
                  ),
                  label: Text(
                    "Details",
                    style: TextStyle(color: Colors.orange),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              TextFormField(
                controller: cubit.noteController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter note!";
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.note_alt_outlined,
                    color: Colors.orange,
                  ),
                  label: Text("Note", style: TextStyle(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30.sp,
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.newAddress) {
                      cubit.addAddress();
                      cubit.getAddress();
                    } else {
                      cubit.updateAddress();
                      cubit.getAddress();
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 242, 219, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
    );
  }
}
