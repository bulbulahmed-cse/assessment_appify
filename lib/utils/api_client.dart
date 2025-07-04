import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appifylab_assessment/utils/extensions.dart';
import 'package:appifylab_assessment/utils/share_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../../main.dart';
import '../model/auth.dart';
import '../widgets/force_logout_dialog.dart';
import '../widgets/show_message.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiClient {
  List<Dio> clients = [];

  Map<String, String> headerWithAuth(Auth? auth, Map<String, String>? headers) => {
    "Accept": "application/json",
    'Authorization': 'Bearer ${auth?.token ?? ''}',
  }..addAll(headers ?? {});

  Map<String, String> headerWithoutAuth(Map<String, String>? headers) => {
    "Accept": "application/json",
  }..addAll(headers ?? {});

  void close() {
    for (int i = 0; i < clients.length; i++) {
      clients[i].close();
    }
    clients.clear();
  }

  Future request({
    required String url,
    Method method = Method.GET,
    var body,
    Map<String, String>? headers,
    List<String>? fileKey,
    List<File>? files,
    required Function onSuccess,
    required Function onError,
    bool forceLogout = true,
    bool withAuth = true,
  }) async {
    Auth? auth = Auth.data;

    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    clients.add(dio);

    try {
      Response? response;
      final options = Options(headers: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers));

      switch (method) {
        case Method.POST:
          response = await dio.post(url, data: body, options: options);
          break;
        case Method.DELETE:
          response = await dio.delete(url, options: options);
          break;
        case Method.PATCH:
          response = await dio.patch(url, data: body, options: options);
          break;
        case Method.PUT:
          response = await dio.put(url, data: body, options: options);
          break;
        default:
          response = await dio.get(url, options: options);
          break;
      }

      showData(url: url, response: response.data, body: body, method: method, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: response.statusCode);

      try {
        dynamic data = response.data;
        if ([200, 204, 201, 422, 412, 404].contains(response.statusCode) || [200, 204, 201, 422, 412].contains(data['statusCode'])) {
          onSuccess(data);
        } else {
          ErrorMessage(message: data['message']);
          onError(data);
        }
      } on Error catch (e) {
        'Http Error = ${e.toString()}\n${e.stackTrace}'.log;
        onError({'message': 'Something went wrong', 'statusCode': response.statusCode});
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        log('TimeoutException Error = ${e.message}');
        showData(body: body, method: method, response: e.response?.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response?.statusCode);
        ErrorMessage(message: 'Check your internet connection');
        onError({'message': 'Check your internet connection'});
      } else if (e.type == DioExceptionType.unknown && e.error is SocketException) {
        log('SocketException Error = ${e.message}');
        showData(body: body, method: method, response: e.response?.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response?.statusCode);
        ErrorMessage(message: 'Check your internet connection');
        onError({'message': 'Something went wrong'});
      } else if([204, 201, 422, 412, 400, 404].contains(e.response!.statusCode)){
        showData(body: body, method: method, response: e.response!.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response!.statusCode);
        onSuccess(e.response!.data);
      } else if(e.response!.statusCode == 401){
        showData(body: body, method: method, response: e.response!.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response!.statusCode);
        if(auth != null){
          showForceLogoutDialog();
          ShareHelper.doLogout();
        }
        onError(e.response!.data);
      } else {
        log('Error = ${e.toString()}');
        showData(body: body, method: method, response: e.response!.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response!.statusCode);
        onError(e.response?.data ?? {'message': 'Something went wrong'});
      }
    }
  }

  static Future showForceLogoutDialog() async {
    bool isDialogVisible = logoutDialogKey.currentState?.isVisible ?? false;
    if (isDialogVisible) return;

    'Loading dialog is visible now'.log;
    await showCupertinoDialog(
      context: appContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ForceLogoutDialog(key: logoutDialogKey);
      },
    );
  }

  Future requestWithFile({
    required String url,
    Map<String, String>? body,
    Map<String, String>? headers,
    List<String>? fileKey,
    List<File>? files,
    Method method = Method.POST,
    required Function onSuccess,
    required Function onError,
    bool withAuth = true,
  }) async {
    Map<String, dynamic> result;
    Auth? auth = Auth.data;

    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    clients.add(dio);

    try {
      final options = Options(headers: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers));
      final formData = FormData.fromMap(body!);

      for (int i = 0; i < fileKey!.length; i++) {
        formData.files.add(MapEntry(
          fileKey[i],
          await MultipartFile.fromFile(files![i].path, filename: basename(files[i].path)),
        ));
      }

      Response response;
      switch (method) {
        case Method.POST:
          response = await dio.post(url, data: formData, options: options);
          break;
        case Method.PUT:
          response = await dio.put(url, data: formData, options: options);
          break;
        case Method.PATCH:
          response = await dio.patch(url, data: formData, options: options);
          break;
        default:
          response = await dio.post(url, data: formData, options: options);
          break;
      }

      result = response.data;
      showData(body: body, method: method, response: result, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: response.statusCode);

      Map<String, dynamic> data = {};
      try {
        data = response.data;
      } catch (e) {
        data = {
          'success': true,
          'message': response.statusCode == 413 ? 'File size is Too Large' : 'Something went wrong',
        };
      }

      if ([200, 204, 201, 422, 412].contains(response.statusCode) || [200, 204, 201, 422, 412].contains(data['statusCode'])) {
        onSuccess(data);
      } else {
        ErrorMessage(message: data['message']);
        onError(data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        log('TimeoutException Error = ${e.message}');
        showData(body: body, method: method, response: e.response?.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response?.statusCode);
        ErrorMessage(message: 'Check your internet connection');
        onError({'message': 'Check your internet connection'});
      } else if (e.type == DioExceptionType.unknown && e.error is SocketException) {
        log('SocketException Error = ${e.message}');
        showData(body: body, method: method, response: e.response?.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response?.statusCode);
        ErrorMessage(message: 'Check your internet connection');
        onError({'message': 'Check your internet connection'});
      } else if([204, 201, 422, 412, 400, 404].contains(e.response!.statusCode)){
        showData(body: body, method: method, response: e.response!.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response!.statusCode);
        onSuccess(e.response!.data);
      } else if(e.response!.statusCode == 401){
        showData(body: body, method: method, response: e.response!.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response!.statusCode);
        if(auth != null){
          showForceLogoutDialog();
          ShareHelper.doLogout();
        }
        onError(e.response!.data);
      } else {
        log('Error = ${e.toString()}');
        showData(body: body, method: method, response: e.response!.data, url: url, header: withAuth ? headerWithAuth(auth, headers) : headerWithoutAuth(headers), statusCode: e.response!.statusCode);
        onError(e.response?.data ?? {'message': 'Something went wrong'});
      }
    }
  }

  void showData({required String url, dynamic body, required dynamic header, required dynamic statusCode, required dynamic response, required dynamic method}) {
    if (kDebugMode) {
      log("URL = $url");
      log("Body = $body");
      log("Header = $header");
      log("Status Code = $statusCode");
      log("Method = $method");
      log("Response = $response");
    }
  }
}
