import 'package:appifylab_assessment/main.dart';
import 'package:flutter/material.dart';

class Helper{

  static Future showProgress() async {
    await showDialog(
      context: appContext,
      barrierDismissible: false,
      builder: (context){
        return Dialog(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator()
                ),
                SizedBox(width: 16,),
                Text(
                  'Loading...',
                  style: appTheme(context).textTheme.headlineLarge,
                )
              ],
            ),
          ),
        );
      }
    );
  }
}