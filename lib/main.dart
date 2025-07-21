import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shop_bolt/ui/amazon_screen/screen/amazon_screen.dart';
import 'package:shop_bolt/ui/app_manager/app_manager_cubit.dart';
import 'package:shop_bolt/ui/app_manager/app_manager_state.dart';
import 'package:shop_bolt/ui/login_screen/screen/login_screen.dart';
import 'package:shop_bolt/utils/app_dio.dart';

import 'database/shared_preferences.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  AppDio.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppManagerCubit(),
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) =>
            BlocBuilder<AppManagerCubit, AppManagerState>(
              buildWhen: (previous, current) => current is SettingsChange,
              builder: (context, state) {
                return MaterialApp(
                  locale: Locale(
                    PreferenceUtils.getString(PrefKeys.language, 'en'),
                  ),
                  supportedLocales: S.delegate.supportedLocales,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: false,
                    primarySwatch: Colors.orange,
                    scaffoldBackgroundColor: Colors.white,
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                          backgroundColor: Colors.white,
                          selectedItemColor: Colors.orange,
                          unselectedItemColor: Colors.grey,
                        ),
                    textTheme: TextTheme(
                      bodyLarge: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  darkTheme: ThemeData(
                    useMaterial3: false,
                    primarySwatch: Colors.orange,
                    scaffoldBackgroundColor: Colors.black,
                    bottomNavigationBarTheme:
                        const BottomNavigationBarThemeData(
                          backgroundColor: Colors.black,
                          selectedItemColor: Colors.orange,
                          unselectedItemColor: Colors.grey,
                        ),
                    textTheme: TextTheme(
                      bodyLarge: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  themeMode: PreferenceUtils.getBool(PrefKeys.darkTheme)
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home: PreferenceUtils.getString(PrefKeys.apiToken) == ''
                      ? const LoginScreen()
                      : const AmazonScreen(),
                );
              },
            ),
      ),
    );
  }
}
