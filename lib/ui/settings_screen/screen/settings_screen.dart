import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../database/shared_preferences.dart';
import '../../../generated/l10n.dart';
import '../../app_manager/app_manager_cubit.dart';
import '../../app_manager/app_manager_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
        ),
        title: Text(
          S().settings,
          style: TextStyle(
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.sp, horizontal: 15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                  Icon(
                    Icons.color_lens_outlined,
                    color: Colors.orange,
                    size: 22.sp,
                  ),
                  SizedBox(width: 20.sp),
                  Expanded(
                    child: Text(
                      S().theme,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      PreferenceUtils.setBool(
                        PrefKeys.darkTheme,
                        !PreferenceUtils.getBool(PrefKeys.darkTheme),
                      );
                      BlocProvider.of<AppManagerCubit>(
                        context,
                      ).onSettingsChange();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: const Color.fromRGBO(255, 217, 146, 1),
                      elevation: 0,
                    ),
                    child: BlocBuilder<AppManagerCubit, AppManagerState>(
                      buildWhen: (previous, current) =>
                          current is SettingsChange,
                      builder: (context, state) {
                        return Icon(
                          PreferenceUtils.getBool(PrefKeys.darkTheme)
                              ? Icons.nightlight_outlined
                              : Icons.light_mode_outlined,
                          color: Colors.orange,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                  Icon(Icons.language, color: Colors.orange, size: 22.sp),
                  SizedBox(width: 20.sp),
                  Expanded(
                    child: Text(
                      S().language,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        clipBehavior: Clip.hardEdge,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.sp),
                        ),
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    PreferenceUtils.setString(
                                      PrefKeys.language,
                                      'ar',
                                    );
                                    BlocProvider.of<AppManagerCubit>(
                                      context,
                                    ).onSettingsChange();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40.sp,
                                    padding: EdgeInsets.all(15.sp),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                        255,
                                        242,
                                        219,
                                        0.8,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        16.sp,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/images/arabic_icon.png",
                                          width: 30.sp,
                                          height: 30.sp,
                                        ),
                                        Text(
                                          'العربية',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        PreferenceUtils.getString(
                                                  PrefKeys.language,
                                                  'en',
                                                ) ==
                                                'ar'
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.orange,
                                                size: 22.sp,
                                              )
                                            : Text(
                                                'AR',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    PreferenceUtils.setString(
                                      PrefKeys.language,
                                      'en',
                                    );
                                    BlocProvider.of<AppManagerCubit>(
                                      context,
                                    ).onSettingsChange();
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40.sp,
                                    padding: EdgeInsets.all(15.sp),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                        255,
                                        242,
                                        219,
                                        0.8,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        16.sp,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/images/english_icon.png",
                                          width: 30.sp,
                                          height: 30.sp,
                                        ),
                                        Text(
                                          'English',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        PreferenceUtils.getString(
                                                  PrefKeys.language,
                                                  'en',
                                                ) ==
                                                'en'
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.orange,
                                                size: 22.sp,
                                              )
                                            : Text(
                                                'EN',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
            ),
          ],
        ),
      ),
    );
  }
}
