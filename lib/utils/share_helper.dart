import 'dart:convert';

import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/model/auth.dart';
import 'package:appifylab_assessment/routes/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/dependency.dart';

class ShareHelper{
  static SharedPreferences? preferences;
  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    //preferences!.clear();
    getAuth();
  }


  static void setAuth(Auth auth){
    instance.registerSingleton<Auth>(auth);
    preferences!.setString("auth", jsonEncode(auth.toJson()));
  }

  static Auth? getAuth(){
    String? data = preferences!.getString("auth");
    if(data != null){
      Auth au = Auth.fromJson(jsonDecode(data));
      instance.registerSingleton<Auth>(au);
      return au;
    }
    return null;
  }


  static void doLogout(){
    preferences!.remove('auth');
    if(Auth.data != null) {
      instance.unregister<Auth>(instance: Auth.data!);
    }
    goAndRemoveAllPage(Routes.loginPage);
  }

}