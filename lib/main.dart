import 'dart:io';

import 'package:appifylab_assessment/modules/dashboard/view/dashboard_view.dart';
import 'package:appifylab_assessment/modules/login/login_view.dart';
import 'package:appifylab_assessment/modules/splash/splash_screen.dart';
import 'package:appifylab_assessment/routes/route.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/dependency.dart';
import 'modules/create_post/create_post_view.dart';

final GlobalKey<NavigatorState> navigatorKey= GlobalKey();
Future goToPage(String routeName,{dynamic arguments}) async => await navigatorKey.currentState!.pushNamed(routeName,arguments: arguments);
Future goAndRemoveAllPage(String routeName,{dynamic arguments}) async => await navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName,(Route<dynamic> route) => false,arguments: arguments);
void backPage([dynamic data])=> navigatorKey.currentState!.pop(data);
BuildContext appContext = navigatorKey.currentContext!;
ThemeData appTheme([BuildContext? context])=> Theme.of(context ?? appContext);


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
    // ..maxConnectionsPerHost = 2
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await ShareHelper.init();
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'AppifyLab Assessment',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              scaffoldBackgroundColor: Color(0xFFF3F3F3),
              textTheme: const TextTheme(
                  headlineLarge: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                  headlineMedium: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                  bodyLarge: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),
                  bodyMedium: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  )
              )
          ),
          routes: {
            Routes.splash: (context) => const SplashScreen(),
            Routes.loginPage: (context) => const LoginPage(),
            Routes.dashboard: (context) => DashboardPage(),
            Routes.createPost: (context) => const CreatePostPage(),
          },
          initialRoute: Routes.splash,
        );
      },
    );
  }
}