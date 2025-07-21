import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/shared_preferences.dart';
import '../../../models/app_endpoints.dart';
import '../../../models/login_response.dart';
import '../../../utils/app_dio.dart';
import '../../../utils/flutter_toast.dart';
import 'login_screen_state.dart';

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
