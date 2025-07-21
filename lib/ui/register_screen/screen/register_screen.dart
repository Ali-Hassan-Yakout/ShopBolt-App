import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../manager/register_screen_cubit.dart';
import '../manager/register_screen_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final cubit = RegisterScreenCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterScreenCubit, RegisterScreenState>(
        listener: (context, state) {
          if (state is Register) {
            navToLogin();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/shopbolt_logo.png',
                      width: 70.sp,
                      height: 70.sp,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.sp,
                      vertical: 25.sp,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.sp),
                        topRight: Radius.circular(25.sp),
                      ),
                    ),
                    child: Form(
                      key: cubit.formKey,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: 10.sp),
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
                          SizedBox(height: 20.sp),
                          TextFormField(
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
                          SizedBox(height: 20.sp),
                          TextFormField(
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
                          SizedBox(height: 20.sp),
                          BlocBuilder<AppManagerCubit, AppManagerState>(
                            buildWhen: (previous, current) =>
                                current is ObscureChange,
                            builder: (context, state) {
                              return TextFormField(
                                controller: cubit.passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter password!";
                                  }
                                  return null;
                                },
                                obscureText: cubit.obscure1,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.orange,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      cubit.obscure1 = !cubit.obscure1;
                                      BlocProvider.of<AppManagerCubit>(
                                        context,
                                      ).onObscureChange();
                                    },
                                    icon: Icon(
                                      cubit.obscure1 == true
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  label: Text(
                                    S().password,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                    ),
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
                              );
                            },
                          ),
                          SizedBox(height: 20.sp),
                          BlocBuilder<AppManagerCubit, AppManagerState>(
                            buildWhen: (previous, current) =>
                                current is ObscureChange,
                            builder: (context, state) {
                              return TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please re-enter password!";
                                  }
                                  if (value != cubit.passwordController.text) {
                                    return "Those password didn't match";
                                  }
                                  return null;
                                },
                                obscureText: cubit.obscure2,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.orange,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      cubit.obscure2 = !cubit.obscure2;
                                      BlocProvider.of<AppManagerCubit>(
                                        context,
                                      ).onObscureChange();
                                    },
                                    icon: Icon(
                                      cubit.obscure2 == true
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  label: Text(
                                    S().reEnterPassword,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                    ),
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
                              );
                            },
                          ),
                          SizedBox(height: 20.sp),
                          SizedBox(
                            width: double.infinity,
                            height: 30.sp,
                            child: ElevatedButton(
                              onPressed: () {
                                cubit.register();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.sp),
                                ),
                              ),
                              child: Text(
                                S().register,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.sp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S().alreadyHave,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              TextButton(
                                onPressed: () {
                                  navToLogin();
                                },
                                child: Text(
                                  S().login,
                                  style: TextStyle(fontSize: 16.sp),
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
            ),
          ),
        ),
      ),
    );
  }

  void navToLogin() {
    Navigator.pop(context);
  }
}
