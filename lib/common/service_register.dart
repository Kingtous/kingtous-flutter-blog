import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kingtous_blog/network/api_service.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;
final logger = Logger();

class ServiceRegister{
  static void registerAllServices(){
    _registerRetrofit();
  }

  static void _registerRetrofit(){
    final dio = Dio();
    dio.options.headers["client"] = "flutter-my-blog";
    final apiService = ApiService(dio);
    getIt.registerSingleton<ApiService>(apiService);
  }
}