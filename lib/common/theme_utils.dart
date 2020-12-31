import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/common/theme.dart';
import 'package:theme_provider/theme_provider.dart';

class ThemeUtils {

  /// 是否是黑暗模式
  static bool isDarkMode(BuildContext context) {
    return ThemeProvider.themeOf(context).id == "dark";
  }

  static AppTheme getAppLightTheme(){
    return AppTheme(
      data: ThemeData(brightness: Brightness.light,textTheme: GoogleFonts.notoSansTextTheme()),
      id: "light",
      description: "Android Default Light Theme",
    );
  }

  static AppTheme getAppDarkTheme(){
    return AppTheme(
      data: myTheme,
      id: "dark",
      description: "Android Default Light Theme",
    );
  }
}
