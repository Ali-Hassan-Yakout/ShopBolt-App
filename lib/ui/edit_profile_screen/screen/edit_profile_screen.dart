import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../manager/edit_profile_screen_cubit.dart';
import '../manager/edit_profile_screen_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final cubit = EditProfileScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getProfile();
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
            S().editProfile,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<EditProfileScreenCubit, EditProfileScreenState>(
          buildWhen: (previous, current) => current is GetProfile,
          builder: (context, state) => cubit.loading
              ? Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Form(
                    key: cubit.formKey,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 20.sp),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.sp,
                          padding: EdgeInsets.all(15.sp),
                          margin: EdgeInsets.only(bottom: 17.sp),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 242, 219, 0.8),
                            borderRadius: BorderRadius.circular(16.sp),
                          ),
                          child: TextFormField(
                            controller: cubit.nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter name!";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outlined,
                                color: Colors.orange,
                              ),
                              label: Text(
                                S().name,
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
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.sp,
                          padding: EdgeInsets.all(15.sp),
                          margin: EdgeInsets.only(bottom: 17.sp),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 242, 219, 0.8),
                            borderRadius: BorderRadius.circular(16.sp),
                          ),
                          child: TextFormField(
                            maxLength: 11,
                            controller: cubit.phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter phone!";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone_outlined,
                                color: Colors.orange,
                              ),
                              label: Text(
                                S().phone,
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
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.sp,
                          padding: EdgeInsets.all(15.sp),
                          margin: EdgeInsets.only(bottom: 17.sp),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 242, 219, 0.8),
                            borderRadius: BorderRadius.circular(16.sp),
                          ),
                          child: TextFormField(
                            controller: cubit.emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter email!";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.orange,
                              ),
                              label: Text(
                                S().email,
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
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.sp,
                          padding: EdgeInsets.all(15.sp),
                          margin: EdgeInsets.only(bottom: 17.sp),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 242, 219, 0.8),
                            borderRadius: BorderRadius.circular(16.sp),
                          ),
                          child: BlocBuilder<AppManagerCubit, AppManagerState>(
                            buildWhen: (previous, current) =>
                                current is ObscureChange,
                            builder: (context, state) => TextFormField(
                              controller: cubit.passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter password!";
                                }
                                return null;
                              },
                              obscureText: cubit.obscure,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.orange,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.obscure = !cubit.obscure;
                                    BlocProvider.of<AppManagerCubit>(
                                      context,
                                    ).onObscureChange();
                                  },
                                  icon: Icon(
                                    cubit.obscure == true
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.orange,
                                  ),
                                ),
                                label: Text(
                                  S().password,
                                  style: TextStyle(color: Colors.orange),
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
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 30.sp,
                          child: ElevatedButton(
                            onPressed: () {
                              cubit.updateProfile();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.sp),
                              ),
                            ),
                            child: Text(
                              S().update,
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
