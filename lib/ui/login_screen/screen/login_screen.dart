import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../amazon_screen/screen/amazon_screen.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';
import '../../register_screen/screen/register_screen.dart';
import '../manager/login_screen_cubit.dart';
import '../manager/login_screen_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final cubit = LoginScreenCubit();

  @override
  void dispose() {
    super.dispose();
    cubit.passwordController.dispose();
    cubit.emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginScreenCubit, LoginScreenState>(
        listener: (context, state) {
          if (state is Login) {
            navToHome();
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
                          BlocBuilder<AppManagerCubit, AppManagerState>(
                            buildWhen: (previous, current) =>
                                current is ObscureChange,
                            builder: (context, state) {
                              return TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter password!";
                                  }
                                  return null;
                                },
                                controller: cubit.passwordController,
                                obscureText: cubit.obscure,
                                textInputAction: TextInputAction.done,
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
                                cubit.login();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.sp),
                                ),
                              ),
                              child: Text(
                                S().login,
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
                                S().doNotHave,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              TextButton(
                                onPressed: () {
                                  navToRegister();
                                },
                                child: Text(
                                  S().register,
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

  void navToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void navToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AmazonScreen()),
      (route) => false,
    );
  }
}
