import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bolt/ui/profile_screen/manager/profile_screen_state.dart';

import '../../../models/app_endpoints.dart';
import '../../../models/profile_response.dart';
import '../../../utils/app_dio.dart';

class ProfileScreenCubit extends Cubit<ProfileScreenState> {
  ProfileScreenCubit() : super(ProfileScreenInitial());
  bool loading = true;
  String userName = '';
  String email = '';

  Future<void> getProfile() async {
    final response = await AppDio.get(endPoint: EndPoints.profile);
    final profileResponse = ProfileResponse.fromJson(response.data);
    userName = profileResponse.data.name;
    email = profileResponse.data.email;
    loading = false;
    emit(GetProfile());
  }
}
