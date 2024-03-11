import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/ui/amazon_screen/manager/amazon_screen_state.dart';
import 'package:shopbolt/ui/home_screen/screen/home_screen.dart';
import 'package:shopbolt/ui/profile_screen/screen/profile_screen.dart';
import 'package:shopbolt/ui/search_screen/screen/search_screen.dart';

class AmazonScreenCubit extends Cubit<AmazonScreenState> {
  AmazonScreenCubit() : super(AmazonScreenInitial());
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  onScreenChange(){
    emit(ScreenChange());
  }
}
