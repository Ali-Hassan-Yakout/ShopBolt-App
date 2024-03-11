import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/models/app_endpoints.dart';
import 'package:shopbolt/models/profile_response.dart';
import 'package:shopbolt/models/update_profile_response.dart';
import 'package:shopbolt/ui/edit_profile_screen/manager/edit_profile_screen_state.dart';
import 'package:shopbolt/utils/app_dio.dart';
import 'package:shopbolt/utils/flutter_toast.dart';

class EditProfileScreenCubit extends Cubit<EditProfileScreenState> {
  EditProfileScreenCubit() : super(EditProfileScreenInitial());
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = false;
  bool loading = true;

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final response = await AppDio.put(
      endPoint: EndPoints.updateProfile,
      body: {
        "name": nameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "password": passwordController.text
      },
    );
    final updateResponse = UpdateProfileResponse.fromJson(response.data);
    showToast(updateResponse.message);
  }

  Future<void> getProfile() async {
    final response = await AppDio.get(endPoint: EndPoints.profile);
    final profileResponse = ProfileResponse.fromJson(response.data);
    nameController.text = profileResponse.data.name;
    phoneController.text = profileResponse.data.phone;
    emailController.text = profileResponse.data.email;
    loading = false;
    emit(GetProfile());
  }
}
