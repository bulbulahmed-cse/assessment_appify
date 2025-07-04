import 'dart:async';

import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/model/auth.dart';
import 'package:appifylab_assessment/routes/route.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';
import '../../utils/dimension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Dimension.init();
    Timer(const Duration(seconds: 3), (){
      if(Auth.data != null){
        goAndRemoveAllPage(Routes.dashboard);
      } else {
        goAndRemoveAllPage(Routes.loginPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.loginBack.path
            ),
            fit: BoxFit.cover
          )
        ),
        alignment: Alignment.center,
        child: Assets.banner.svg(),
      ),
    );
  }
}
