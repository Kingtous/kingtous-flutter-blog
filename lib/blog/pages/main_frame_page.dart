/*
 * @Author: Kingtous
 * @Date: 2020-10-28 16:36:31
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-10-28 18:35:12
 * @Description: 主要框架
 */
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:kingtous_blog/blog/detail/blog_detail.dart';
import 'package:kingtous_blog/blog/pages/base/base_frame_page.dart';
import 'package:kingtous_blog/blog/pages/welcome_page.dart';
import 'package:theme_provider/theme_provider.dart';

/// 主框架Page
class MainFramePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MainFrameState();
}

class _MainFrameState extends BaseFramePageState<MainFramePage>{
  @override
  Widget buildContent(BuildContext context) {
    return WelcomePage();
  }

}
