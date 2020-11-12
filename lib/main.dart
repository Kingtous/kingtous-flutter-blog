/*
 * @Author: Kingtous
 * @Date: 2020-10-14 22:52:38
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-11-12 18:23:56
 * @Description: Kingtous' Code
 */
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:kingtous_blog/app_module.dart';
import 'package:kingtous_blog/blog/detail/blog_detail.dart';
import 'package:kingtous_blog/blog/detail/providers/blog_detail_provider.dart';
import 'package:kingtous_blog/blog/pages/main_frame_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BlogDetailProvider()),
        ],
        child: ThemeProvider(
          themes: [
            AppTheme.light(
                id: "light"), // This is standard light theme (id is default_light_theme)
            AppTheme.dark(
                id: "dark"), // This is standard dark theme (id is default_dark_theme)
          ],
          child: ThemeConsumer(
              child: Builder(
            builder: (themeContext) => GetMaterialApp(
              title: 'Kingtous的个人博客 | Kingtous\' Blog',
              theme: ThemeProvider.themeOf(themeContext).data,
              getPages: [
                GetPage(name: "/", page: ()=>MyHomePage()),
                GetPage(name: "/note", page: ()=>BlogDetailPage()),
                GetPage(name: "/index", page: ()=>BlogDetailPage()),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final endDrawerKey = GlobalKey<DrawerControllerState>();
  static final drawerKey = GlobalKey<DrawerControllerState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1920, 1080), allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kingtous个人博客 | Kingtous Blog"),
      ),
      body: MainFramePage(),
      floatingActionButton: FloatingActionButton(
        tooltip: '搜索',
        onPressed: () {  },
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(
          child: Column(
        children: [FlatButton(onPressed: null, child: Text("首页"))],
      )),
      endDrawer: _buildDrawer(context),
    );
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
                  width: 20.w,
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
}
