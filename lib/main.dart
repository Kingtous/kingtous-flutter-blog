/*
 * @Author: Kingtous
 * @Date: 2020-10-14 22:52:38
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-11-12 18:23:56
 * @Description: Kingtous' Code
 */
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/app_module.dart';
import 'package:kingtous_blog/blog/detail/blog_detail.dart';
import 'package:kingtous_blog/blog/detail/providers/blog_detail_provider.dart';
import 'package:kingtous_blog/blog/pages/about_page.dart';
import 'package:kingtous_blog/blog/pages/blog_detail_page.dart';
import 'package:kingtous_blog/blog/pages/blog_page.dart';
import 'package:kingtous_blog/blog/pages/main_frame_page.dart';
import 'package:kingtous_blog/blog/pages/route_notfound_page.dart';
import 'package:kingtous_blog/common/service_register.dart';
import 'package:kingtous_blog/common/theme_utils.dart';
import 'package:kingtous_blog/network/api_service.dart';
import 'package:logger/logger.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceRegister.registerAllServices();
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
            ThemeUtils.getAppLightTheme(),
            // This is standard dark theme (id is default_dark_theme)
            ThemeUtils.getAppDarkTheme(),
            // This is standard light theme (id is default_light_theme)

          ],
          child: ThemeConsumer(
              child: Builder(
            builder: (themeContext) => GetMaterialApp(
              builder: (context, widget) => ResponsiveWrapper.builder(
                  ClampingScrollWrapper.builder(context, widget),
                  maxWidth: 1440,
                  minWidth: 600,
                  defaultScale: true,
                  breakpoints: [
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                  ],
                  background: Container(
                    color: ThemeUtils.isDarkMode(context)
                        ? Colors.black
                        : Colors.white,
                  )),
              title: 'Kingtous的个人博客 | Kingtous\' Blog',
              theme: ThemeProvider.themeOf(themeContext).data,
              getPages: [
                GetPage(
                    name: "/",
                    page: () => MainFramePage(),transition: Transition.fade),
                GetPage(
                    name: "/note/:page_id",
                    page: () => BlogDetailPage(),transition: Transition.fade),
                GetPage(
                    name: "/pages",
                    page: () => BlogPage(),transition: Transition.fade),
                GetPage(
                    name: "/about",
                    page: () => AboutMePage(),transition: Transition.fade),
              ],
              unknownRoute:
                  GetPage(name: '/404', page: () => RouteNotFoundPage(),transition: Transition.native),
            ),
          )),
        ),
      ),
    );
  }
}
