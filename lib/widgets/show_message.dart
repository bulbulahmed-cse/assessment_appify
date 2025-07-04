import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/dimension.dart';


void SuccessMessage({required String message, Widget? icon, bool visibleIcon = true, Function? then, BorderRadius? borderRadius, double? maxWidth}){
  Flushbar(
    messageText: Text(message, style: appTheme().textTheme.bodyLarge!.copyWith(
      fontWeight: Dimension.textMedium,
      color: AppColor.white,
      fontSize: 15.spMin
    ),),
    icon: visibleIcon ? icon ?? Icon(Icons.check_circle, color: AppColor.white,) : null,
    backgroundColor: const Color(0xFF35CC0F),
    padding: REdgeInsets.only(left: 16, top: 13, bottom: 13),
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    maxWidth: maxWidth,
    borderRadius: borderRadius,
  ).show(appContext).then((value) {
    if(then!=null) {
      then();
    }
  });
}
void ErrorMessage({required var message, Widget? icon, Function? then, BorderRadius? borderRadius, double? maxWidth}){
  Flushbar(
    messageText: Text(message, style: appTheme().textTheme.bodyLarge!.copyWith(
      fontWeight: Dimension.textMedium,
      color: AppColor.white,
      fontSize: 15.spMin
    ),),
    icon: icon ?? Icon(Icons.cancel, color: AppColor.white,),
    backgroundColor: const Color(0xFFFB3C3C),
    padding: REdgeInsets.only(left: 16, top: 13, bottom: 13),
    duration: const Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: borderRadius,
    maxWidth: maxWidth,
  ).show(appContext).then((value) {
    if(then!=null) {
      then();
    }
  });
}