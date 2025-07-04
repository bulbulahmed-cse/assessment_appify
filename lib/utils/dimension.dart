import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class Dimension{
  static FontWeight textLight=FontWeight.w300;
  static FontWeight textRegular=FontWeight.w400;
  static FontWeight textMedium=FontWeight.w500;
  static FontWeight textSemiBold=FontWeight.w600;
  static FontWeight textBold=FontWeight.w700;
  static FontWeight textExtraBold=FontWeight.w800;

  static double cardElevation = 5;


  static late double paddingTop;
  static late double paddingBottom;
  static SizedBox bottomSpace = (paddingBottom>0 ? paddingBottom : 16).verticalSpace;

  static init(){
    paddingTop=MediaQuery.of(appContext).padding.top;
    paddingBottom = MediaQuery.of(appContext).padding.bottom;
  }
}