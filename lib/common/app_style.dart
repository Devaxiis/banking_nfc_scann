
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

sealed class AppStyle{
 
 static thin(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) async =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w100,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
        wordSpacing: wordSpace.sp
      );
 static extraLight(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w200,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
        wordSpacing: wordSpace.sp
      );
 static light(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w300,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
        wordSpacing: wordSpace.sp
      );
 static regular(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w400,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
        wordSpacing: wordSpace.sp
      );
 static medium(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0
      }) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w500,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
        wordSpacing: wordSpace.sp
      );
static semiBold(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w600,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
          wordSpacing: wordSpace.sp

      );
      static bold(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w700,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
          wordSpacing: wordSpace.sp
      );
      static extraBold(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w800,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
        wordSpacing: wordSpace.sp
      );
      static black(
      {double size = 18,
        Color color = AppColor.clPrWhiteFFFFFF,
        double letterSpacing = 0,
        double wordSpace = 0}) =>
      TextStyle(
          color: color,
          fontFamily: "Golos",
          fontWeight: FontWeight.w900,
          fontSize: size,
          letterSpacing: letterSpacing.sp,
        wordSpacing: wordSpace.sp
      );

}