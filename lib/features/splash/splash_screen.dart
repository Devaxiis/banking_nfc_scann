
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/app_color.dart';
import '../../common/app_routes.dart';
import '../../common/app_style.dart';
import '../../common/models/shared_model.dart';
import '../../di/injector.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void launch() async {
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).pushReplacement(Routes.home,extra: {
        "number":"",
        "date":""
      });
      // di<SharedPreferences>().getString(SharedModel.token) != null
      //     ? di<SharedPreferences>().getBool(SharedModel.isRegistered) == true
      //         ? GoRouter.of(context).go(Routes.home)
      //         : GoRouter.of(context).go(Routes.login)
      //     // : GoRouter.of(context).pushReplacement(Routes.onboard);
      //     : GoRouter.of(context).pushReplacement(Routes.login);
    });
    
  }
  @override
  void initState() {
    super.initState();
    launch();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.clPrWhiteFFFFFF,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              Text("Banking app",style: AppStyle.bold(size: 28,color: AppColor.clPrDark010513),),
              Text("Powered by devaxis",style: AppStyle.extraLight(size: 14,color: AppColor.clPrDark010513),)
            ],
          ),
        ),
      ),
    );
  }
}
