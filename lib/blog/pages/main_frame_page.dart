/*
 * @Author: Kingtous
 * @Date: 2020-10-28 16:36:31
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-10-28 18:35:12
 * @Description: 主要框架
 */
import 'package:flutter/material.dart';
import 'package:kingtous_blog/blog/pages/welcome_page.dart';

class MainFrameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
    );
  }
}

class MainFramePage extends StatefulWidget {
  @override
  _MainFramePageState createState() => _MainFramePageState();
}

class _MainFramePageState extends State<MainFramePage> {
  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}
