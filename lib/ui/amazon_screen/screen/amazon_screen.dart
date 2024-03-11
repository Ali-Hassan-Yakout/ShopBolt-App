import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopbolt/generated/l10n.dart';
import 'package:shopbolt/ui/amazon_screen/manager/amazon_screen_cubit.dart';
import 'package:shopbolt/ui/amazon_screen/manager/amazon_screen_state.dart';
import 'package:shopbolt/ui/app_manager/app_manager_cubit.dart';
import 'package:shopbolt/ui/app_manager/app_manager_state.dart';

class AmazonScreen extends StatefulWidget {
  const AmazonScreen({super.key});

  @override
  State<AmazonScreen> createState() => _AmazonScreenState();
}

class _AmazonScreenState extends State<AmazonScreen> {
  final cubit = AmazonScreenCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<AmazonScreenCubit, AmazonScreenState>(
        buildWhen: (previous, current) => current is ScreenChange,
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BlocBuilder<AppManagerCubit, AppManagerState>(
              buildWhen: (previous, current) => current is SettingsChange,
              builder: (context, state) {
                return BottomNavigationBar(
                  showUnselectedLabels: false,
                  currentIndex: cubit.currentIndex,
                  onTap: (value) {
                    cubit.currentIndex = value;
                    cubit.onScreenChange();
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: S().home,
                      icon: const Icon(Icons.home_filled),
                    ),
                    BottomNavigationBarItem(
                      label: S().search,
                      icon: const Icon(Icons.search),
                    ),
                    BottomNavigationBarItem(
                      label: S().profile,
                      icon: const Icon(Icons.person_outlined),
                    ),
                  ],
                );
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
