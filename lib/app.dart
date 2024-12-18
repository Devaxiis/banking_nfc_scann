import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'common/app_color.dart';
import 'common/app_routes.dart';
import 'common/constants.dart';
import 'common/theme/theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(
        create: (context) {
          themeNotifier = ThemeNotifier(Brightness.light);
          return themeNotifier;
        }),
    ],
        child: Consumer<ThemeNotifier>(
          builder: (BuildContext context, ThemeNotifier value, Widget? child) {
            return ScreenUtilInit(
              designSize: const Size(375, 770),
              builder: (context, child) =>MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
                child: ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) {
                    return MaterialApp.router(
                  theme: ThemeData(
                    focusColor: AppColor.clPrBackgroundf5f7f9,
                    scaffoldBackgroundColor: AppColor.clPrBackgroundf5f7f9,
                  ),
                  debugShowCheckedModeBanner: false,
                  themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  routerConfig: AppRoutes.router,
                );
      
      
                  },
                )
                )
            );
          },
        ),

    );
  }
}
