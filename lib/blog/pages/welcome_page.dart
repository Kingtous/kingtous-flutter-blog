/*
 * @Author: Kingtous
 * @Date: 2020-10-28 16:34:20
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-11-12 18:28:07
 * @Description: 带搜索条的欢迎页
 */
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kingtous_blog/blog/detail/providers/blog_detail_provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showSimpleNotification(Text("欢迎~"),
          position: NotificationPosition.bottom);
    });
  }

  void _search(content) {
    Provider.of<BlogDetailProvider>(context, listen: false)
        .setPath("assets/notes/test_note.md");
    Get.toNamed('/note');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ThemeProvider.themeOf(context).id == 'light'
              ? Color(0xFF217FCC)
              : Colors.black),
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: FlareActor(
              "assets/flrs/welcome.flr",
              animation: ThemeProvider.themeOf(context).id == 'light'
                  ? "welcome"
                  : 'welcome_dark',
              fit: BoxFit.fitWidth,
              callback: (s) {
                Get.log("animation ended");
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(300.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 22.h),
                              hintText: "搜索内容",
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.white)),
                          controller: _searchTextController,
                          onSubmitted: (s) => _search(s),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
