import 'dart:async';

import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/repository/auth_repository.dart';
import 'package:appifylab_assessment/routes/route.dart';
import 'package:appifylab_assessment/utils/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository repository = AuthRepository();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  LoginBloc() : super(LoginState().init()) {
    on<InitEvent>(_init);
    on<DoLogin>(_login);
  }

  @override
  Future<void> close() {
    repository.close();
    return super.close();
  }

  void _init(InitEvent event, Emitter<LoginState> emit) async {
    if(kDebugMode){
      email.text = 'janedoe@gmail.com';
      password.text = '7654321';
    }
  }

  FutureOr<void> _login(DoLogin event, Emitter<LoginState> emit) async {
    if(!formKey.currentState!.validate()) return;
    Helper.showProgress();
    await repository.doLogin(
      email: email.text,
      password: password.text,
      onSuccess: (data){
        if(data != null){
          backPage();
          goAndRemoveAllPage(Routes.dashboard);
        }
      },
      onError: (data){
        backPage();
      }
    );
  }
}
