import 'package:appifylab_assessment/https/urls.dart';
import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/model/auth.dart';
import 'package:appifylab_assessment/utils/api_client.dart';
import 'package:appifylab_assessment/utils/helper.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';

class AuthRepository{
  ApiClient client = ApiClient();

  void close(){
    client.close();
  }

  Future doLogin({
  required String email,
  required String password,
  required Function onSuccess,
  required Function onError,
  }) async {
    await client.request(
      url: Urls.login,
      method: Method.POST,
      withAuth: false,
      body: <String, String>{
        'email': email.trim(),
        'password': password.trim(),
      },
      onSuccess: (data){
        Auth auth = Auth.fromJson(data);
        ShareHelper.setAuth(auth);
        onSuccess(auth);
      },
      onError: onError
    );
  }

  Future doLogout({
  required Function onSuccess,
  required Function onError,
  }) async {
    Helper.showProgress();
    await client.request(
      url: Urls.logout,
      method: Method.POST,
      withAuth: false,
      body: <String, String>{},
      onSuccess: onSuccess,
      onError: onError
    );
    backPage();
    ShareHelper.doLogout();
  }
}