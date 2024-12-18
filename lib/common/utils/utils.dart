// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../di/injector.dart';
// import '../app_color.dart';
// import '../app_routes.dart';
// import '../app_style.dart';
// import '../assets.dart';
//
//
// void handleUnAuthorized(BuildContext context) {
//   di<SharedPreferences>().clear();
//   GoRouter.of(context).pushReplacement(Routes.splash);
// }
//
// Widget buildConnectionFailedState(BuildContext context, VoidCallback onTap) {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SvgPicture.asset(Assets.icons.icMic),
//         SizedBox(height: 12.h),
//         Text(
//           'Tarmoq yo\'q!',
//           style: AppStyle.regular(color: AppColor.clPrWhiteFFFFFF),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 45.w),
//           child: Text(
//             "Iltimos, Internetga ulanishingiz to'g'ri ulanganligini tekshiring!",
//             textAlign: TextAlign.center,
//             style: AppStyle.regular(color: AppColor.clPrWhiteFFFFFF),
//           ),
//         ),
//         SizedBox(height: 12.h),
//         // PrimaryButton(
//         //   width: MediaQuery.of(context).size.width / 2,
//         //   color: AppColors().buttonColor,
//         //   onPressed: onTap,
//         //   radius: 16.r,
//         //   text: 'Tarmoqni tekshirish',
//         //   textStyle:
//         //       AppTextStyles().body16w4.copyWith(color: AppColors().background),
//         // )
//       ],
//     ),
//   );
// }
