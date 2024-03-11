import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/database/shared_preferences.dart';
import 'package:shopbolt/models/app_endpoints.dart';
import 'package:shopbolt/models/login_response.dart';
import 'package:shopbolt/ui/login_screen/manager/login_screen_state.dart';
import 'package:shopbolt/utils/app_dio.dart';
import 'package:shopbolt/utils/flutter_toast.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(LoginScreenInitial());
  bool obscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final response = await AppDio.post(
      endPoint: EndPoints.login,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    final loginResponse = LoginResponse.fromJson(response.data);
    if (loginResponse.status) {
      PreferenceUtils.setString(PrefKeys.apiToken, loginResponse.data.token);
      emit(Login());
    } else {
      showToast(loginResponse.message);
    }
  }
}
