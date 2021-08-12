/*
 * @Author: Kingtous
 * @Date: 2020-10-14 23:22:02
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-10-14 23:35:58
 * @Description: Kingtous' Code
 */
import 'package:flutter/material.dart';

class BlogDetailProvider extends ChangeNotifier {
  // 当前的路径
  String? currentPath;

  setPath(String path) {
    currentPath = path;
    notifyListeners();
  }
}
