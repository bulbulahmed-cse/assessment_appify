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

List gradientsColor = const [
  LinearGradient(
    begin: Alignment(-1.0, 0.0),
    end: Alignment(1.0, 0.0),
    transform: GradientRotation(90),
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFFFFFF),
    ],
  ),
  LinearGradient(
    begin: Alignment(-1.0, 0.0),
    end: Alignment(1.0, 0.0),
    transform: GradientRotation(90),
    colors: [
      Color(0xFFff00ea),
      Color(0xFFff7300),
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    transform: GradientRotation(-135),
    colors: [
      Color.fromRGBO(72, 229, 169, 1),
      Color.fromRGBO(143, 199, 173, 1),
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(116, 167, 126, 1),
      Color.fromRGBO(24, 175, 78, 1),
    ],
  ),
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFff7f11),
      Color(0xFFff7f11),
    ],
  ),
  LinearGradient(
    begin: Alignment(-1.0, 0.0),
    end: Alignment(1.0, 0.0),
    transform: GradientRotation(90),
    colors: [
      Color(0xFF00ffe1),
      Color(0xFFe9ff42),
    ],
  )
];
List feedBackGroundGradientColors = [
  "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 115, 0) 0%, rgb(255, 0, 234) 100%)\"}",
  "{\"backgroundImage\":\"linear-gradient(135deg, rgb(143, 199, 173), rgb(72, 229, 169))\"}",
  "{\"backgroundImage\":\"linear-gradient(135deg, rgb(116, 167, 126), rgb(24, 175, 78))\"}",
  "{\"backgroundImage\":\"linear-gradient(45deg, rgb(255, 127, 17) 0%, rgb(255, 127, 17) 100%)\"}",
  "{\"backgroundImage\":\"linear-gradient(45deg, rgb(233, 255, 66) 0%, rgb(0, 255, 225) 100%)\"}"
];



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
          debugShowCheckedModeBanner: false,
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