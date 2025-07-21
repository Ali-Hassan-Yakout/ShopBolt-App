import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen/screen/home_screen.dart';
import '../../profile_screen/screen/profile_screen.dart';
import '../../search_screen/screen/search_screen.dart';
import 'amazon_screen_state.dart';

class AmazonScreenCubit extends Cubit<AmazonScreenState> {
  AmazonScreenCubit() : super(AmazonScreenInitial());
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void onScreenChange() {
    emit(ScreenChange());
  }
}
