import 'package:appifylab_assessment/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../routes/route.dart';
GlobalKey<ForceLogoutDialogState> logoutDialogKey = GlobalKey<ForceLogoutDialogState>();

class ForceLogoutDialog extends StatefulWidget {
  const ForceLogoutDialog({super.key});

  @override
  ForceLogoutDialogState createState() => ForceLogoutDialogState();
}

class ForceLogoutDialogState extends State<ForceLogoutDialog> {
  bool _isVisible = true;

  bool get isVisible => _isVisible;
  set setVisibility(bool state) {
    _isVisible = state;
  }


  @override
  void initState() {
    _isVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    _isVisible = false;
    super.dispose();
  }

  void dismissDialog() {
    if (_isVisible) {
      'Loading dialog is dismissed now'.log;
      try{
        goAndRemoveAllPage(Routes.loginPage);
      } catch(_){}
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CupertinoAlertDialog(
        content: Text(
          "Your session has expired, Please log in again."
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: dismissDialog,
            child: Text(
              "Ok",
              style: appTheme(context).textTheme.bodyLarge!.copyWith(
                color: Colors.blue
              ),
            )
          )
        ],
      ),
    );
  }
}