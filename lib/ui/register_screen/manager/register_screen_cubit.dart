import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/models/app_endpoints.dart';
import 'package:shopbolt/models/register_response.dart';
import 'package:shopbolt/ui/register_screen/manager/register_screen_state.dart';
import 'package:shopbolt/utils/app_dio.dart';
import 'package:shopbolt/utils/flutter_toast.dart';

class RegisterScreenCubit extends Cubit<RegisterScreenState> {
  RegisterScreenCubit() : super(RegisterScreenInitial());
  bool obscure1 = true;
  bool obscure2 = true;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final response = await AppDio.post(
      endPoint: EndPoints.register,
      body: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phone': phoneController.text,
      },
    );
    final registerResponse = RegisterResponse.fromJson(response.data);
    if (registerResponse.status) {
      emit(Register());
    }
    showToast(registerResponse.message);
  }
}
