import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

/// page状态基类，存放一些公用的ui逻辑如显示面板
abstract class BaseFramePageState<T extends StatefulWidget> extends State<T> {

  static var _currentIndex = 0;
  static String title = "Kingtous个人博客 | Kingtous Blog";
  static final endDrawerKey = GlobalKey<DrawerControllerState>();
  static final drawerKey = GlobalKey<DrawerControllerState>();

  static int getCurrentIndex() => _currentIndex;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.notoSans(),
        ),
        elevation: 0,
      ),
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: ThemeProvider.themeOf(context).data.primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildNavigationButton(context),
            ),
          ),
          Expanded(child: buildContent(context))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: '搜索',
        onPressed: () {
          Get.toNamed("/");
        },
        child: Icon(Icons.search),
      ),
      endDrawer: _buildDrawer(context),
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
    );
  }

  static void setTitle(State state, String newString) {
    state.setState(() {
      title = newString;
    });
  }

  List<String> btnName = ["首页", "文章", "标签", "关于"];
  List<String> routeName = ["/", "/pages", "/tags", "/about"];

  List<Widget> _buildNavigationButton(BuildContext context) {
    Map<String, Widget> m = {
      "首页": Icon(
        Icons.home,
        color: Colors.white,
        size: 25,
      ),
      "文章": Icon(
        Icons.pages,
        color: Colors.white,
        size: 25,
      ),
      "标签": Icon(
        Icons.tag,
        color: Colors.white,
        size: 25,
      ),
      "关于": Icon(
        Icons.people,
        color: Colors.white,
        size: 25,
      ),
    };
    List<Widget> btnWidgets = List();
    for (var i = 0; i < btnName.length; i++) {
      btnWidgets.add(Container(
        height: MediaQuery.of(context).size.height / 5,
        child: FlatButton(
          disabledColor: ThemeProvider.themeOf(context).data.hoverColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              m[btnName[i]],
              Text(
                btnName[i],
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: _currentIndex == i
              ? null
              : () {
                  setState(() {
                    _currentIndex = i;
                  });
                  Get.toNamed(routeName[_currentIndex]);
                },
        ),
      ));
    }
    return btnWidgets;
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      semanticLabel: "偏好设置",
      key: endDrawerKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("夜间模式"),
                SizedBox(
                  width: 20,
                ),
                Switch(
                  value: ThemeProvider.themeOf(context).id == 'dark',
                  // true为黑暗模式
                  onChanged: (option) {
                    option
                        ? ThemeProvider.controllerOf(context).setTheme("dark")
                        : ThemeProvider.controllerOf(context).setTheme("light");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 构建内容
  Widget buildContent(BuildContext context);
}
