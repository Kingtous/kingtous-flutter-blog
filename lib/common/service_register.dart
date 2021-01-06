import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kingtous_blog/network/api_service.dart';
import 'package:logger/logger.dart';
import 'package:universal_html/js.dart' as js;

final getIt = GetIt.instance;
final logger = Logger();

class ServiceRegister {
  static void registerAllServices() {
    _registerRetrofit();
  }

  static void _registerRetrofit() {
    final dio = Dio();
    dio.options.headers["client"] = "flutter-my-blog";
    final apiService = ApiService(dio);
    getIt.registerSingleton<ApiService>(apiService);
  }
}

/// 联系我
void invokeContactMeByEmail() {
  js.context.callMethod(
      'open', ['mailto:me@kingtous.cn?subject=[来自我的Flutter博客]&body=描述：']);
}

/// Uri or String
void invokeHrefOpen(href){
  js.context.callMethod(
      'open', [href.toString()]);
}
