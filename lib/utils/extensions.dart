import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as Timeago;
import 'dart:developer' as Lg;

extension StringExtensions on String {


  int get toInt {
    try {
      return int.parse(this);
    } catch(e) {
      return toDouble.round();
    }
  }

  double get toDouble {
    try{
      return double.parse(this);
    } catch(e){
      return 0.0;
    }
  }
  void get log{
    Lg.log(this);
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}


extension TimeExtension on String{
  String get timeEgo {
    final time = DateTime.parse(this);
    return Timeago.format(time);
  }

}