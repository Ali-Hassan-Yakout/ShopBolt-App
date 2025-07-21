import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../database/shared_preferences.dart';
import '../../../generated/l10n.dart';
import '../../edit_profile_screen/screen/edit_profile_screen.dart';
import '../../favorite_screen/screen/favorite_screen.dart';
import '../../login_screen/screen/login_screen.dart';
import '../../orders_screen/screen/orders_screen.dart';
import '../../settings_screen/screen/settings_screen.dart';
import '../manager/profile_screen_cubit.dart';
import '../manager/profile_screen_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final cubit = ProfileScreenCubit();

  @override
  void initState() {
    super.initState();
    cubit.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<ProfileScreenCubit, ProfileScreenState>(
        buildWhen: (previous, current) => current is GetProfile,
        builder: (context, state) => cubit.loading
            ? Scaffold(
                body: Center(
                  child: Lottie.asset('assets/animations/shopping_loader.json'),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    S().profile,
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 25.sp,
                    horizontal: 15.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        cubit.userName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        cubit.email,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 25.sp),
                      profileItemBuilder(
                        title: S().editProfile,
                        icon: Icons.edit_outlined,
                        screen: const EditProfileScreen(),
                      ),
                      profileItemBuilder(
                        title: S().settings,
                        icon: Icons.settings,
                        screen: const SettingsScreen(),
                      ),
                      profileItemBuilder(
                        title: S().favorite,
                        icon: Icons.favorite_border_outlined,
                        screen: const FavoriteScreen(),
                      ),
                      profileItemBuilder(
                        title: S().orders,
                        icon: Icons.shopping_cart_checkout,
                        screen: const OrdersScreen(),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        label: Text(
                          S().logOut,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        icon: Icon(
                          Icons.logout,
                          size: 22.sp,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget profileItemBuilder({
    required String title,
    required IconData icon,
    required Widget screen,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.sp,
      padding: EdgeInsets.all(15.sp),
      margin: EdgeInsets.only(bottom: 17.sp),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 242, 219, 0.8),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 22.sp),
          SizedBox(width: 20.sp),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => screen),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: const Color.fromRGBO(255, 217, 146, 1),
              elevation: 0,
            ),
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    PreferenceUtils.setString(PrefKeys.apiToken, '');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}
